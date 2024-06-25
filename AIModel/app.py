from flask import Flask, json, jsonify, request
from pymongo import MongoClient
from bson import ObjectId
from bson import json_util
import os

app = Flask(__name__)

# MongoDB connection string (replace with your own connection details)
MONGO_URI = os.getenv('MONGO_URI', 'mongodb+srv://MarinaNeseem:Nina01279402974@cluster0.kjkxyqp.mongodb.net/TRD?retryWrites=true&w=majority/')
client = MongoClient(MONGO_URI)

# Database and collection (replace with your own database and collection names)
db = client['TRD']
collection = db['items']

# Helper function to convert ObjectId to string
def convert_objectid(data):
    if isinstance(data, list):
        for item in data:
            if '_id' in item:
                item['_id'] = str(item['_id'])
    elif isinstance(data, dict):
        if '_id' in data:
            data['_id'] = str(data['_id'])
    return data

@app.route('/')
def index():
    return "Welcome to the Flask MongoDB app!"

@app.route('/data', methods=['GET'])
def get_data():
    # Fetch all data from the collection
    data = list(collection.find())
    print('data',data)
    # data = convert_objectid(data)  # Convert ObjectId to string
    return parse_json(data), 200

def parse_json(data):
    return json.loads(json_util.dumps(data))

@app.route('/data', methods=['POST'])
def add_data():
    # Add a new document to the collection
    new_data = request.json
    collection.insert_one(new_data)
    return jsonify({"msg": "Data added successfully!"}), 201

@app.route('/data/<string:data_id>', methods=['GET'])
def get_single_data(data_id):
    # Fetch a single document by some identifier (assuming 'data_id' field exists)
    data = collection.find_one({'data_id': data_id})
    if data:
        data = convert_objectid(data)  # Convert ObjectId to string
        return jsonify(data), 200
    else:
        return jsonify({"msg": "Data not found!"}), 404

@app.route('/data/<string:data_id>', methods=['PUT'])
def update_data(data_id):
    # Update a document by some identifier
    updated_data = request.json
    result = collection.update_one({'data_id': data_id}, {'$set': updated_data})
    if result.modified_count > 0:
        return jsonify({"msg": "Data updated successfully!"}), 200
    else:
        return jsonify({"msg": "No changes made!"}), 404

@app.route('/data/<string:data_id>', methods=['DELETE'])
def delete_data(data_id):
    # Delete a document by some identifier
    result = collection.delete_one({'data_id': data_id})
    if result.deleted_count > 0:
        return jsonify({"msg": "Data deleted successfully!"}), 200
    else:
        return jsonify({"msg": "Data not found!"}), 404

@app.route('/recommend/<string:title>', methods=['GET'])
def recommend(title):
    # Fetch the original document
    original_data = collection.find_one({'title': title})
    print('original_data',original_data)
    if not original_data:
        return jsonify({"msg": "Data not found!"}), 404

    # Assuming we are using 'category' field for recommendations
    category = original_data.get('category')
    if not category:
        return jsonify({"msg": "Category not found in the original data!"}), 400

    # Fetch documents with the same category
    recommendations = list(collection.find({'category': category, 'title': {'$ne': title}}))
    # recommendations = convert_objectid(recommendations)  # Convert ObjectId to string

    print('recommendations',recommendations)

    return parse_json(recommendations), 200

if __name__ == '__main__':
    app.run(host='192.168.1.7', port=4000, debug=True, threaded=False)

