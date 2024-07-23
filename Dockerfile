FROM python:3.12 AS builder

WORKDIR /app

# Install pygame dependencies
RUN apt-get update && apt-get -y install libsdl2-2.0-0 libsdl2-mixer-2.0-0 libsdl2-image-2.0-0 libsdl2-ttf-2.0-0

RUN apt-get install -y python3-opencv

RUN pip install pyinstaller

COPY . /app

RUN pip install -r requirements.txt

RUN pyinstaller --add-data data:data --add-data images:images --onefile src/main.py

FROM alpine

COPY --from=builder /app/dist/main /bin/

RUN apk add --no-cache gcompat


COPY --from=builder /lib/x86_64-linux-gnu/libGL.so.1 /lib/x86_64-linux-gnu/libGL.so.1
COPY --from=builder /lib/x86_64-linux-gnu/libGLdispatch.so.0 /lib/x86_64-linux-gnu/libGLdispatch.so.0
COPY --from=builder /lib/x86_64-linux-gnu/libGLX.so.0 /lib/x86_64-linux-gnu/libGLX.so.0
COPY --from=builder /lib/x86_64-linux-gnu/libxcb.so.1 /lib/x86_64-linux-gnu/libxcb.so.1

# arial serif

COPY --from=builder /lib/x86_64-linux-gnu/libdl.so.2 /lib/x86_64-linux-gnu/libdl.so.2
COPY --from=builder /lib/x86_64-linux-gnu/libz.so.1 /lib/x86_64-linux-gnu/libz.so.1
COPY --from=builder /lib/x86_64-linux-gnu/libpthread.so.0 /lib/x86_64-linux-gnu/libpthread.so.0
COPY --from=builder /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libc.so.6
COPY --from=builder /lib64/ld-linux-x86-64.so.2 /lib64/

COPY --from=builder /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/libm.so.6
COPY --from=builder /lib/x86_64-linux-gnu/librt.so.1 /lib/x86_64-linux-gnu/librt.so.1

ENTRYPOINT [ "main" ]