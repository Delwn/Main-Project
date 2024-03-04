import pandas as pd
import numpy as np
import tensorflow as tf
import firebase_admin
from firebase_admin import credentials, firestore
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import keras

# loading dataset
dataset = pd.read_csv("finalfile.csv")
# loading model
model = tf.keras.models.load_model("model_name.h5")

# features
x = dataset.drop(columns=["fault"])
# output(fault status)
y = dataset["fault"]


X_train, X_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=0)
sc = StandardScaler()
X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)

print(X_test[:20])
values = X_test[:20]
print(values)
status = model.predict(X_test[:20])
# print(values)
status = status > 0.5
# print(status)


values = [[-0.402026946, -0.058965455, 0]]
fault_status = [[True]]

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

collection_name_1 = "History"
collection_name_2 = "Real_Time_Data"

for i in range(len(values)):
    data_point = {
        "x": values[i][0],
        "y": values[i][1],
        "z": values[i][2],
        # "fault_status": fault_status[i][0],
    }
    db.collection(collection_name_1).add(data_point)

print(f"Data uploaded to Firestore in collection {collection_name_1}")
