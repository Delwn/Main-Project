# importing packages
import pandas as pd
import numpy as np
import tensorflow as tf
import firebase_admin
from firebase_admin import credentials, firestore
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import keras

from google.colab import drive

drive.mount("/content/drive")

model = tf.keras.models.load_model("/content/drive/MyDrive/project files/model_name.h5")
values = [[-0.402026946, -0.058965455]]
fault_status = model.predict(values)
fault_status
print(fault_status)

cred = credentials.Certificate(
    "/content/drive/MyDrive/project files/serviceAccountKey.json"
)
# firebase_admin.initialize_app(cred)

db = firestore.client()

collection_name_1 = "History"

for i in range(len(values)):
    data_point = {
        "x": values[i][0],
        "y": values[i][1],
        # "z": values[i][2],
        "fault_status": str(fault_status[i][0]),
    }
    db.collection(collection_name_1).add(data_point)

print(f"Data uploaded to Firestore in collection {collection_name_1}")
