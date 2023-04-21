function convert-pdf-to-gif --description 'convert pdf to gif' -a filename start_slide num_slides rate density
  if test (count $argv) -lt 3
    echo "Usage: convert-pdf-to-gif <filename> <start_slide> <num_slides> [rate=0.5] [density=300]"
    echo "The default density of 300 is quite high and you may need to lower it to 80-150."
  else
    if not test -n "$rate"
      set rate "0.5"
    end
    if not test -n "$density"
      set density "300"
    end

    mkdir "$filename-seq"
    echo "Converting PDF to image sequence..."
    convert -density $density -quality 100 $filename $filename-seq/seq.png

    pushd $filename-seq
    ffmpeg -y -reinit_filter 0 -f image2 -start_number $(math $start_slide - 1) -r $rate -lavfi palettegen=stats_mode=single[pal],[0:v][pal]paletteuse=new=1 -i seq-%d.png -frames:v $num_slides ../out.gif
    popd
    echo "Created out.gif!"

    echo "Cleaning up..."
    rm -r "$filename-seq"
  end
end
