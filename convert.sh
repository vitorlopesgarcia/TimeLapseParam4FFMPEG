# TimeLapseParam4FFMPEG

# Convert images to a size acceptable for Nvidia encoders
ffmpeg -threads 4 -i DSC_%04d.JPG -vf scale=4000:-1 temp/Image_%04d.JPG

# One pass to AVI (lossless)
ffmpeg -threads 4 -i Image%03d.JPG -vf fps=25 -f avi -c:v rawvideo  movie.avi

# From AVI to mp4 (compatible with Instagram)
ffmpeg -i movie.avi -vf scale=-1:1080 -c:v libx264 -crf 18  -preset veryslow -tune film -profile:v baseline -level 3.0 -pix_fmt yuv420p  movie.mp4

# Single pass to mp4 (is it compatible with Instagram?)
ffmpeg -threads 4 -i DSC_%04d.JPG -vf scale=-1:1080 -vf fps=50 -c:v libx264 -crf 18 -preset veryslow -tune film -profile:v baseline -level 3.0 -pix_fmt yuv420p movie.mp4

# Other Parameters
-vf "hflip,vflip" # Flips

# Converting using imagemagick
for i in DSC_*.JPG; do convert $i -resize 4000x4000 temp/$i; done
# or 
for i in DSC_*.JPG; do echo convert $i -resize 4000x4000 temp/$i >> command.txt ; done
# and
cat command.txt | xargs -I CMD --max-procs=8 bash -c CMD
