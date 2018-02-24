# TimeLapseParam4FFMPEG
ffmpeg -threads 4 -i Image%03d.JPG -vf fps=25 -f avi -c:v rawvideo  movie.avi
ffmpeg -i movie.avi -vf scale=-1:1080 -c:v libx264 -crf 18  -preset veryslow -tune film -profile:v baseline -level 3.0 -pix_fmt yuv420p  movie.mp4
