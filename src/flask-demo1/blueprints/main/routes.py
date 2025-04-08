from flask import render_template, request, redirect, url_for, flash, jsonify
from . import main_bp

# Sample data
data_table = [
    {"id": 1, "name": "Item 1", "category": "Category A"},
    {"id": 2, "name": "Item 2", "category": "Category B"},
]

linked_table = [
    {"ID": 1, "Description": "Linked Item 1", "Category": "A", "Link": "/details/1"},
    {"ID": 2, "Description": "Linked Item 2", "Category": "B", "Link": "/details/2"},
]

@main_bp.route('/')
def index():
    return render_template('index.html', data=data_table)

@main_bp.route('/add', methods=['GET', 'POST'])
def add_item():
    if request.method == 'POST':
        name = request.form.get('name')
        category = request.form.get('category')
        new_item = {"id": len(data_table) + 1, "name": name, "category": category}
        data_table.append(new_item)
        flash("Item added successfully!")
        return redirect(url_for('main.index'))
    return render_template('add_item.html')

@main_bp.route('/linked_table')
def linked_table_view():
    return render_template('linked_table.html', data=linked_table)

@main_bp.route('/export')
def export_data():
    return jsonify(data_table)

@main_bp.route('/details/<int:item_id>')
def details(item_id):
    # Find the item in the linked_table by ID
    item = next((row for row in linked_table if row["ID"] == item_id), None)
    if not item:
        flash("Item not found!")
        return redirect(url_for('main.linked_table_view'))
    return render_template('details.html', item=item)