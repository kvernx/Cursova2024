import random
import pandas as pd
from datetime import datetime, timedelta


def generate_random_kid_date():
    start_date = datetime(2007, 1, 1)
    end_date = datetime(2016, 12, 31)
    
    # Calculate the difference in days between start_date and end_date
    delta = end_date - start_date
    
    # Generate a random number of days within the range
    random_days = random.randint(0, delta.days)
    
    # Add the random number of days to the start_date
    random_date = start_date + timedelta(days=random_days)
    
    return random_date


def generate_random_phone_number():
    # Generate 9 random digits for the phone number
    random_digits = ''.join([str(random.randint(0, 9)) for _ in range(9)])
    
    # Concatenate with the country code (380 for Ukraine)
    phone_number = '380' + random_digits
    
    return phone_number


def generate_random_supervisor_date():
    start_date = datetime(2000, 1, 1)
    end_date = datetime(2002, 12, 31)
    
    # Generate a random number of seconds within the range
    random_seconds = random.randint(0, int((end_date - start_date).total_seconds()))
    
    # Add the random number of seconds to the start_date
    random_date = start_date + timedelta(seconds=random_seconds)
    
    return random_date


# GENERATE HOUSE
house_id = [i for i in range(1, 11)]
house_name = [
    "Marichka",
    "Fialka",
    "Druzhba",
    "Lastivka",
    "Zirka",
    "Nichka",
    "Sontse",
    "Spryna",
    "Dobro",
    "Zapas"
]
data = {"id":house_id,"name":house_name}
houses = pd.DataFrame(data=data,columns=["id", "name"])
houses.to_csv("./data/House.csv", index=False)

# GENERATE ROOM
room_id = []
room_houseId = []
room_number = []
room_balcony = []
room_floor = []
room_bedAmount = []
room_rid = 0
for i in range(1,len(house_id)+1):
    for n in range(1,random.randint(5,7)):
        room_rid +=1
        room_id.append(room_rid)
        room_number.append(n)
        room_houseId.append(i)
        if n==3 or n==4:
            room_balcony.append(True)
            room_floor.append(2)
        else:
            room_balcony.append(False)
            room_floor.append(1)
        room_bedAmount.append(4)
        
data = {"id":room_id,"number":room_number,"balcony":room_balcony,"floor":room_floor,"houseId":room_houseId,"bedAmount":room_bedAmount}
rooms = pd.DataFrame(data=data,columns=["id", "number","balcony","floor","houseId","bedAmount"])
rooms.to_csv("./data/Room.csv", index=False)

# GENERATE BED
bed_id = []
bed_number = []
bed_roomId = []
bed_bid = 0
for roomId in room_id:
    for n in range(1,5):
        bed_bid +=1
        bed_id.append(bed_bid)
        bed_roomId.append(roomId)
        bed_number.append(n)

data = {"id":bed_id,"number":bed_number,"roomId":bed_roomId}
beds = pd.DataFrame(data=data,columns=["id", "number","roomId"])
beds.to_csv("./data/Bed.csv", index=False)

# GENERATE USERS
users_login = ["admin", "supervisor"]
users_password = ["admin","supervisor"]
data = {"login":users_login,"password":users_password}
users = pd.DataFrame(data=data,columns=["login", "password"])
users.to_csv("./data/Users.csv", index=False)

# GENERATE ARRIVAL
arrival_id = [i for i in range(1,16)]
arrival_beginningDate = ['2021-06-03','2021-06-27','2021-07-17','2021-08-04','2021-08-20','2022-06-07','2022-06-28','2022-07-15','2022-08-06','2022-08-17','2023-06-04','2023-06-18','2023-07-06','2023-08-01','2023-08-16']
arrival_endDate = ['2021-06-13','2021-07-04','2021-07-27','2021-08-17','2021-08-30','2022-06-17','2022-07-07','2022-07-25','2022-08-16','2022-08-27','2023-06-14','2023-06-28','2023-07-16','2023-08-11','2023-08-26'] 
arrival_price = [3000, 3000,3000,3000,3000,4000,4000,4000,4000,4000, 4500, 4500,4500,4500,4500]
data = {"id":arrival_id,"beginningDate":arrival_beginningDate,"endDate":arrival_endDate,"price":arrival_price}
arrivals = pd.DataFrame(data=data,columns=["id", "beginningDate","endDate","price"])
arrivals.to_csv("./data/Arrival.csv", index=False)

# GENERATE DETACHMENT
detachment_id = [i for i in range(1,16)]
detachment_name = ["Lito" for i in range(1,16)]
detachment_arrivalId = [i for i in range(1,16)]
data = {"id":detachment_id,"name":detachment_name,"arrivalId":detachment_arrivalId}
detachments = pd.DataFrame(data=data,columns=["id", "name","arrivalId"])
detachments.to_csv("./data/Detachment.csv", index=False)

# GENERATE CONTACT
contact_id = []
contact_name = []
contact_surname = []
contact_adress = []
contact_birthDate = []
contact_phoneNumber = []
contact_sex = []

ukrainian_male_names = ["Andrii", "Bohdan", "Vitalii", "Yevhen", "Ivan", "Oleh", "Pavlo", "Roman", "Fedir"]
ukrainian_female_names = ["Halyna", "Daryna", "Zhanna", "Kateryna", "Veronika", "Larysa", "Mariia", "Nataliia", "Svitlana"]
ukrainian_surnames = ["Antonenko", "Bilenko", "Vasylchenko", "Hrytsenko", "Danylenko", "Yevdokymenko", "Kovalko", "Balanenko", "Ivanchenko", "Kovalenko", "Lysenko", "Melko", "Nesterenko", "Oleksiyenko", "Pavlenko", "Romanchuko", "Sydorenko", "Tkachenko", "Usenko", "Fedorenko"]
ukrainian_cities = ["Sambir", "Lviv", "Odesa", "Kyiv", "Rivne", "Strii", "Dnipro", "Frankivsk"]

contact_cid = 0

for a in arrival_id:
    for i in range(1,sum(room_bedAmount)-1):
        contact_cid +=1
        contact_id.append(contact_cid)
        if i%2 == 0:
            contact_name.append(random.choice(ukrainian_male_names))
            contact_surname.append(random.choice(ukrainian_surnames))
            contact_sex.append('m')
        else:
            contact_name.append(random.choice(ukrainian_female_names))
            contact_surname.append(random.choice(ukrainian_surnames))
            contact_sex.append('f')
        contact_adress.append(random.choice(ukrainian_cities))
        contact_birthDate.append(generate_random_kid_date())
        contact_phoneNumber.append(generate_random_phone_number())

# ADD SUPERVISORS
supervisor_contact_cid = contact_cid+1
for j in range(1, 21):
    contact_cid +=1
    contact_id.append(contact_cid)
    if j%2 == 0:
        contact_name.append(random.choice(ukrainian_male_names))
        contact_surname.append(random.choice(ukrainian_surnames))
        contact_sex.append('m')
    else:
        contact_name.append(random.choice(ukrainian_female_names))
        contact_surname.append(random.choice(ukrainian_surnames))
        contact_sex.append('f')
    contact_adress.append(random.choice(ukrainian_cities))
    contact_birthDate.append(generate_random_supervisor_date())
    contact_phoneNumber.append(generate_random_phone_number())


data = {"id":contact_id,"name":contact_name,"surname":contact_surname,"adress":contact_adress,"birthDate":contact_birthDate,"phoneNumber":contact_phoneNumber,"sex":contact_sex}
contacts = pd.DataFrame(data=data,columns=["id", "name","surname","adress","birthDate","phoneNumber","sex"])
contacts.to_csv("./data/Contact.csv", index=False)
 
# ADD CLIENTS
client_id = []
client_alergy = []
client_preferences = []
client_bedId = []
client_contactId = []
client_detachmentId = []

client_cid = 0
alergies = ["fur", "orange", "apple"]
preferences = ["more football", "tasty food", "more sleep", "computer games"]

for a in arrival_id:
    for i in range(1,sum(room_bedAmount)-1):
        client_cid +=1
        client_id.append(client_cid)
        if random.randint(1, 100) > 95:
            client_alergy.append(random.choice(alergies))
        else:
            client_alergy.append(" ")
        client_preferences.append(0)
        client_bedId.append(i)
        client_contactId.append(client_cid)
        client_detachmentId.append(a)

data = {"id":client_id,"alergy":client_alergy,"preferences":client_preferences,"bedId":client_bedId,"contactId":client_contactId,"detachmentId":client_detachmentId}
clients = pd.DataFrame(data=data,columns=["id", "alergy","preferences","bedId","contactId","detachmentId"])
clients.to_csv("./data/Client.csv", index=False)

# ADD SUPERVISORS
supervisor_id = []
supervisor_contactId = []
supervisor_detachmentId = []        
supervisor_cid = 0
for i in range(supervisor_contact_cid, supervisor_contact_cid+20):
    for j in range(1,arrival_id[-1]+1):
        supervisor_cid += 1
        supervisor_id.append(supervisor_cid)
        supervisor_detachmentId.append(j)
        supervisor_contactId.append(i)
data = {"id":supervisor_id,"contactId":supervisor_contactId,"detachmentId":supervisor_detachmentId}
supervisors = pd.DataFrame(data=data,columns=["id", "contactId","detachmentId"])
supervisors.to_csv("./data/Supervisor.csv", index=False)

