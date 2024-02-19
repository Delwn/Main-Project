import csv
import firebase_admin
from firebase_admin import credentials, firestore

values = [[-0.402026946, -0.058965455, 0]]
fault_status = [[True]]

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

collection_name = "Machine DATA"

for i in range(len(values)):
    data_point = {
        "x": values[i][0],
        "y": values[i][1],
        "z": values[i][2],
        "fault_status": fault_status[i][0],
    }
    db.collection(collection_name).add(data_point)


print(f"Data uploaded to Firestore in collection {collection_name}")
