FROM python:3.14.2-slim-trixie

ARG YT_DLP_VERSION
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y curl libcurl4-openssl-dev unzip\
    && curl -fsSL https://deno.land/install.sh | sh \
    && apt-get remove --purge -y unzip \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install --no-cache-dir \
    -r requirements.txt \
    yt-dlp[default,curl-cffi]==${YT_DLP_VERSION}

COPY ./ffmpeg /usr/local/bin/ffmpeg
COPY ./ffprobe /usr/local/bin/ffprobe

RUN chmod a+rx /usr/local/bin/ffmpeg /usr/local/bin/ffprobe
ENV PATH="/usr/local/bin:${PATH}"

CMD ["python", "./main.py"]