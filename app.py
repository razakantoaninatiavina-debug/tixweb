from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

taches = []

@app.route("/")
def accueil():
    return render_template("index.html", taches=taches)

@app.route("/ajouter", methods=["POST"])
def ajouter():
    texte = request.form.get("texte", "").strip()
    if texte:
        taches.append(texte)
    return redirect(url_for("accueil"))

@app.route("/supprimer/<int:index>", methods=["POST"])
def supprimer(index):
    if 0 <= index < len(taches):
        taches.pop(index)
    return redirect(url_for("accueil"))

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
