# Dockerfile für mxlrc auf dem Raspberry Pi 5

# 1. Basis-Image auswählen
# Wir verwenden ein schlankes Python-Image, das für die ARM64-Architektur des Raspberry Pi 5 geeignet ist.
FROM python:3.11-slim

# 2. Arbeitsverzeichnis im Container festlegen
# Alle nachfolgenden Befehle werden in diesem Verzeichnis ausgeführt.
WORKDIR /app

# 3. Benötigte Python-Pakete installieren
# Zuerst kopieren wir die requirements.txt und installieren dann die Abhängigkeiten.
# --no-cache-dir reduziert die Größe des finalen Images.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Anwendungsdateien kopieren
# Wir kopieren das Haupt-Skript und das Entrypoint-Skript in das Arbeitsverzeichnis.
COPY mxlrc.py .
COPY entrypoint.sh .

# 5. Entrypoint-Skript ausführbar machen
RUN chmod +x entrypoint.sh

# 6. Den Container so konfigurieren, dass er beim Start unser Skript ausführt
ENTRYPOINT ["./entrypoint.sh"]
