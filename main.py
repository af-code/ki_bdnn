import pandas as pd
from keras.models import Sequential
from keras.layers import Dense
from sklearn.tree import DecisionTreeRegressor
import os
os.environ['PYTHONHASHSEED'] = '0'

def create_keras_model(x,y,x_test,y_test):
    training = []
    test = []
    for i in range(0,100):
        k_model = Sequential()
        k_model.add(Dense(4, input_dim=4, activation='relu'))
        k_model.add(Dense(4, activation='relu'))
        k_model.add(Dense(1, activation='relu'))
        k_model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
        k_model.fit(x, y, epochs=30, batch_size=5)
        _, accuracy = k_model.evaluate(x, y)
        print('Accuracy: %.2f' % (accuracy*100))
        training.append((accuracy * 100))
        _, accuracy_test = k_model.evaluate(x_test, y_test)
        print(' TEST Accuracy: %.2f' % (accuracy_test * 100))
        test.append((accuracy_test * 100))
    print("NNtrain",training)
    print("NNtest",test)

def create_decision_tree_model(x,y,x_test,y_test):
    training = []
    test = []
    for i in range(0, 100):
        d_model = DecisionTreeRegressor(max_depth=5)
        d_model.fit(x, y)
        print("Training", d_model.score(x,y))
        training.append(d_model.score(x,y))
        print("TEST DATEN", d_model.score(x_test, y_test))
        test.append(d_model.score(x_test, y_test))
    print("DTtrain",training)
    print("DTtest",test)

if __name__ == '__main__':
    df = pd.read_csv(r"iris.csv")
    df_test = pd.read_csv(r"test_iris.csv")
    x = df.iloc[:, 0:4]
    y = df.iloc[:, 4]
    x_test = df_test.iloc[:, 0:4]
    y_test = df_test.iloc[:, 4]
    create_decision_tree_model(x,y,x_test,y_test)
    create_keras_model(x,y,x_test,y_test)