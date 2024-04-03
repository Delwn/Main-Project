import joblib;
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

model = joblib.load("svm_model.pkl")

# dataset = pd.read_csv("dataset_svm.csv")
# sampled_dataset = dataset.sample(n=500, random_state=0)
# x = sampled_dataset.drop(columns=["fault"])
# y = sampled_dataset["fault"]
# X_train, X_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=0)


# sc = StandardScaler()
# X_train = sc.fit_transform(X_train)
# X_test = sc.transform(X_test)

pred = model.predict(np.array([[0.09326171875,0.195068359375, 0.77001953125]]))
print(pred)