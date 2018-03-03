# TimeLapseParam4FFMPEG

# One pass to AVI (lossless)
ffmpeg -threads 4 -i Image%03d.JPG -vf fps=25 -f avi -c:v rawvideo  movie.avi

# From AVI to mp4 (compatible with Instagram)
ffmpeg -i movie.avi -vf scale=-1:1080 -c:v libx264 -crf 18  -preset veryslow -tune film -profile:v baseline -level 3.0 -pix_fmt yuv420p  movie.mp4

# Single pass to mp4 (is it compatible with Instagram?)
ffmpeg -threads 4 -i DSC_%04d.JPG -vf scale=-1:1080 -vf fps=50 -c:v libx264 -crf 18 -preset veryslow -tune film -profile:v baseline -level 3.0 -pix_fmt yuv420p movie.mp4

# Single pass to mp4, using Nvidia encoder (Compatible with Instagram, maximum width for input=4000)
ffmpeg -hwaccel cuvid -i DSC_%04d.JPG -vf scale=-1:720 -vf fps=40 -c:v h264_nvenc  -preset slow -profile:v high -b:v 15M  -pix_fmt yuv420p -vf deshake  movie.mp4


# Other Parameters
-vf "hflip,vflip" # Flips
-loglevel debug # Debug information


# Resizing figures using imagemagick
for i in DSC_*.JPG; do convert $i -resize 720x720 temp/$i; done
# or 
for i in DSC_*.JPG; do echo convert $i -resize 720x720 temp/$i >> command.txt ; done
# and
cat command.txt | xargs -I CMD --max-procs=4 bash -c CMD

# Rotate using imagemagick
for i in DSC_*.JPG; do echo convert $i -flip -flop temp/$i >> command.txt ; done
# and
cat command.txt | xargs -I CMD --max-procs=4 bash -c CMD
