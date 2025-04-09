# Importiere Flask, die Hauptklasse für die Erstellung der Anwendung
from flask import Flask

# Importiere den Blueprint aus dem Modul "blueprints.main"
from blueprints.main import main_bp

# Funktion zur Erstellung der Flask-Anwendung
def create_app():
    # Initialisiere die Flask-Anwendung
    app = Flask(__name__)
    
    # Konfiguriere die Anwendung (z. B. für Sicherheitsschlüssel)
    app.config['SECRET_KEY'] = 'your_secret_key'

    # Registriere den Blueprint, um Routen und Logik auszulagern
    app.register_blueprint(main_bp)

    # Gib die konfigurierte Anwendung zurück
    return app

# Überprüfe, ob die Datei direkt ausgeführt wird
if __name__ == "__main__":
    # Erstelle die Anwendung
    app = create_app()
    
    # Starte den Flask-Entwicklungsserver im Debug-Modus
    app.run(debug=True)