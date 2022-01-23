#!/bin/bash

dotf=$XDG_DATA_HOME/chezmoi/
# dependencies 
# atool
jq=$dotf/bin/jq
fd=$dotf/bin/fd
fzf=$dotf/bin/fzf

local=~/.local/binaries
if [ ! -d "$local" ]; then
  mkdir -p $local
fi

user=$1
repo=$2
userrepo="${user}/${repo}"

# set binary name from 3. argument or reponame
if [ -z "$3" ]; then
  binname=$repo
else
  binname=$3
fi

# get latest version tag string of repo or from 4. argument 
if [ -z "$4" ]; then
  version=`git ls-remote --refs --sort="version:refname" --tags https://github.com/${userrepo} | cut -d/ -f3- | tail -n1`
else
  version=$4
fi

bin_json=$dotf/bin/binaries.json
echo repo: $repo
echo current version: `$jq -r ".\"${repo}\" | .version" $bin_json` 

# check if local version of binary is up to date
if ( $jq -e ".\"${repo}\" | .version == \"${version}\"" $bin_json > /dev/null ); then
  echo $repo 'is up to date'
else
  echo wanted version: $version

  # write json data of version to temp file
  curl "https://api.github.com/repos/${userrepo}/releases" -s | $jq "map(select(.tag_name == \"${version}\")) | .[0]" > temp.json

  # if repo has file_name in $bin_json
  if ( $jq -e ".\"${repo}\" | .file_name" $bin_json > /dev/null ); then
    # load previous file_name from json
    file_name=`$jq -r ".\"${repo}\" | .file_name" $bin_json`
  else
    # query user for file_name name with fzf
    file_name=`$jq -r ".assets | .[].name" temp.json | $fzf --query="!sha !sum !256 !sig !win !exe$ !msi$ !js$ !wasm$ !mac !darwin !dmg$ !arm !arch !deb$ !rpm$ !apk$ !snap$ !appimage$ !686 !386 'linux | '64 | 'tar | 'tz$ | 'gz$ | ^${binname}$ " -1`
    # cut out the version from file_name
    file_name=`echo $file_name | sed -r -e "s/${version}//" -e "s/$(echo $version | tr -d v)//"`
  fi

  # get the full file name from file_name
  full_file_name=`$jq -r ".assets | .[].name" temp.json | $fzf --query="!sha !sum !256 !sig ${file_name}" -1`
  # extract download url using full_file_name
  url=`cat temp.json | $jq -r ".assets | map(select(.name == \"${full_file_name}\")) | .[].browser_download_url"`

  rm temp.json

  # write update to $bin_json
  $jq "(del(.\"${repo}\")) + {\"${repo}\": {version: \"${version}\",  file_name: \"${file_name}\"}}" $bin_json > temp.json
  rm $bin_json > /dev/null
  mv temp.json $bin_json

  target="$local/$repo"
  # delete old files
  if [ -d "$target" ]; then
    rm -rf $target
  fi
  mkdir -p $target

  pushd $target > /dev/null

  # download into "archive" file
  echo downloading
  wget -q -O archive $url
  if (atool -q -X $target archive); then
    # if extraction succeeded remove archive
    rm -r -f archive
  else
    # if extraction failed its probably a binary, so rename it
    mv archive $binname; chmod +x $binname
  fi

  # symlink the binaries
  bin_dir=~/.local/bin
  bin=`$fd -t x -E "*.so*" -E "*.sh" -E "*.bat" -E "*.awk"`

  # rename binary to binname
  [ $binname != `basename $bin` ] && mv $bin `dirname $bin`/$binname && bin=`dirname $bin`/$binname
  [ -n "$bin" ] && echo linking binaries && echo $bin
  echo $bin | xargs -I{} ln -fs $target/{} $bin_dir

  # symlink completion files
  zsh_comp_dir=~/.local/zsh-fpath
  if [ ! -d "$zsh_comp_dir" ]; then
    mkdir -p $zsh_comp_dir
  fi
  comp=`$fd -t f "^(.*_${binname}|.*complet.*${binname}\.zsh)$" -E "bash"`

  [ -n "$comp" ] && echo linking completion files && echo $comp && \
  echo $comp | xargs -I{} ln -fs $target/{} $zsh_comp_dir/_$binname

  # symlink man
  man1_dir=~/.local/share/man/man1
  if [ ! -d "$man1_dir" ]; then
    mkdir -p $man1_dir
  fi
  man1=`$fd -t f -E "*.so.*" "\.1$"`
  [ -n "$man1" ] && echo linking man files && echo $man1 && \
  echo $man1 | xargs -n 1 echo | xargs -I{} ln -fs $target/{} $man1_dir 

  man5_dir=~/.local/share/man/man5
  if [ ! -d "$man5_dir" ]; then
    mkdir -p $man5_dir
  fi
  man5=`$fd -t f -E "*.so.*" "\.5$"`
  [ -n "$man5" ] && echo linking man files && echo $man5 && \
  echo $man5 | xargs -n 1 echo | xargs -I{} ln -fs $target/{} $man5_dir 

  popd > /dev/null
fi
