FROM n8nio/n8n:latest

USER root

# Install Python, packages, ffmpeg และ fontconfig
RUN apk add --no-cache \
    python3 py3-pip \
    poppler-utils \
    ffmpeg \
    fontconfig \
    ttf-freefont

# สร้าง virtual environment และติดตั้ง typhoon-ocr
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install typhoon-ocr

# เพิ่ม virtual environment ลงใน PATH
ENV PATH="/opt/venv/bin:$PATH"

# คัดลอกฟอนต์จากโฟลเดอร์ fonts บน host ไปยัง container
COPY fonts /usr/share/fonts/custom

# สร้างแคชฟอนต์ใหม่
RUN fc-cache -f -v

# สร้าง directories และกำหนด permission
RUN mkdir -p /data /doc && \
    chown -R node:node /data /doc

USER node
WORKDIR /home/node
