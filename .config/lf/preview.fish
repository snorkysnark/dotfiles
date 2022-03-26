#!/usr/bin/fish

if [ $lf_preview = "false" ]
	exit 1
end

set file $argv[1]
set dimensions "$argv[2]x$argv[3]@$argv[4]x$argv[5]"

function draw
		kitty +kitten icat --silent --transfer-mode file --place $dimensions $argv[1]
		exit 1
end

function try_draw
		if test -e $argv[1]
			draw $argv[1]
		end
end

function hash
	set -l stat (realpath $argv[1] | sha256sum | cut -d' ' -f1)
  echo "$HOME/.cache/lf/$stat.jpg"
end

switch (file -Lb --mime-type -- $file)
	case 'image/vnd.djvu'
		exit 1
	case 'image/*'
		draw $file
	case 'video/*'
		set -l cached (hash $file)
		try_draw $cached
		ffmpegthumbnailer -i $file -o $cached -s 0
		draw $cached
	case 'application/pdf'
		set -l cached (hash $file)
		try_draw $cached
		convert (printf '%s[0]' $file) $cached
		draw $cached
	case 'application/zip'
		unzip -l $file
	case 'application/x-bzip2' 'application/gzip' 'application/zstd'
		tar -tf $file
	case 'application/x-rar'
		7z l $file
	case '*'
		bat -p --color always $file
end
