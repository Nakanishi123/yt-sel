ARG YT_DLP_VERSION

FROM python:3.13.7-trixie

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y curl libcurl4-openssl-dev\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    beautifulsoup4==4.13.5 \
    icecream==2.1.8 \
    selenium==4.35.0 \
    yt-dlp[default,curl-cffi]==${YT_DLP_VERSION}

COPY ./ffmpeg /usr/local/bin/ffmpeg
COPY ./ffprobe /usr/local/bin/ffprobe
RUN chmod a+rx /usr/local/bin/ffmpeg /usr/local/bin/ffprobe
ENV PATH="/usr/local/bin:${PATH}"

CMD ["python", "./main.py"]