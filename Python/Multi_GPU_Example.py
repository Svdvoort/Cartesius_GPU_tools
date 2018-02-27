from keras.models import Sequential
from keras.layers import Conv2D, MaxPooling2D
from keras.layers.core import Activation, Flatten, Dense
import Cartesius_Multi_GPU_Tools as CMGT


def example_model():
    model = Sequential()
    model.add(Conv2D(16, (3, 3), activation='linear',
                     input_shape=(512, 512, 1)))
    model.add(Activation.ReLU())   # add an advanced activation
    model.add(MaxPooling2D(pool_size=(5, 5)))
    model.add(Flatten())
    model.add(Dense(1024))
    model.add(Activation.ReLU())   # add an advanced activation
    model.add(Dense(2))
    model.add(Activation('softmax'))

    return model

model = example_model

multi_GPU_model, CPU_model = CMGT.create_multi_GPU_model(model, dict())

multi_GPU_model.compile(loss='categorical_crossentropy',
                        optimizer='Adam',
                        metrics=['categorical_accuracy'])

# Use the MultiGPU checkpoint, otherwise you'll get errors while saving
checkpoint = CMGT.MultiGPUCheckpointCallback('/path/to/save/mode.hdf5',
                             monitor='val_categorical_accuracy', verbose=1,
                             save_best_only=True, mode='max')

# Here do the fitting
multi_GPU_model.fit(train_X, train_Y, epochs=10, callbacks=[checkpoint])

# Finally, saving the model requires saving the CPU model, not the multi_GPU_model
# Weights are shared between them, so this is not a problem.
CPU_model.save('/path/to/save/model.hdf5')
