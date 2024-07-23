FROM python:3.12

WORKDIR /app

# Install pygame dependencies
RUN apt-get update && apt-get -y install libsdl2-2.0-0 libsdl2-mixer-2.0-0 libsdl2-image-2.0-0 libsdl2-ttf-2.0-0

RUN apt-get install -y python3-opencv

COPY . /app

RUN pip install -r requirements.txt

ENTRYPOINT [ "python3", "src/main.py" ]