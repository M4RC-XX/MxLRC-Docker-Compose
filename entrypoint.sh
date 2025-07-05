#!/bin/sh
# entrypoint.sh - Start-Skript für den mxlrc-Container

# Bricht das Skript bei Fehlern sofort ab
set -e

# --- Konfiguration aus Umgebungsvariablen lesen ---
# Standardwerte werden verwendet, falls die Variablen nicht gesetzt sind.
MUSIC_DIR_INTERNAL=${MUSIC_DIR:-/music}
SLEEP_TIME_INTERNAL=${SLEEP_TIME:-15}
UPDATE_FLAG=""

# Überprüfen, ob der Musixmatch-Token gesetzt ist. Wenn nicht, beenden.
if [ -z "$MX_TOKEN" ]; then
    echo "Fehler: Die Umgebungsvariable MX_TOKEN ist nicht gesetzt."
    exit 1
fi

# Wenn UPDATE_FILES auf "true" gesetzt ist, fügen wir das --update Flag hinzu.
if [ "$UPDATE_FILES" = "true" ]; then
    UPDATE_FLAG="--update"
fi

echo "Starte den Download der Liedtexte..."
echo "Zielverzeichnis (im Container): $MUSIC_DIR_INTERNAL"
echo "Pausenzeit zwischen Anfragen: ${SLEEP_TIME_INTERNAL}s"

# Führe das eigentliche Python-Skript mit allen Parametern aus.
# 'exec' ersetzt den aktuellen Prozess, was eine bewährte Methode in Docker ist.
exec python mxlrc.py \
    --token "$MX_TOKEN" \
    -s "$MUSIC_DIR_INTERNAL" \
    --sleep "$SLEEP_TIME_INTERNAL" \
    $UPDATE_FLAG
