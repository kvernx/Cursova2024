class Child:
    def __init__(self, name, age, gender, id):
        self.name = name
        self.age = age
        self.gender = gender
        self.id = id
  

class House:
    def __init__(self, capacity, name):
        self.capacity = capacity
        self.name = name
        self.children = []

    def __str__(self):
        return str(str(self.capacity) + " " + str(self.name))
