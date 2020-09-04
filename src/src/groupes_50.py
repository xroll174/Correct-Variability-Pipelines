import random

def partie(s,n): #Construit une partie de s éléments distincts entre 1 et n
    l = []
    while(len(l) < s):
        k = random.randint(1,n)
        if not(k in l):
            l.append(k)
    return l

def couple(s,n):
    l1 = partie(2*s,n)
    l2 = l1[0:s]
    l3 = l1[s:2*s]
    return (l2,l3)
    

def liste_parties(e,s,n): #Construit une liste de e sous-ensembles d'entiers de taille s construits avec la fct partie
    l0 = []
    for i in range(e):
        l1 = partie(s,n)
        l0.append(l1)
    return l0

def liste_couples(e,s,n): #Construit une liste de e couples de sous-ensembles d'entiers de taille s construits avec la fct couple
    l0 = []
    for i in range(e):
        l1 = couple(s,n)
        l0.append(l1)
    return l0

random.seed(10)
liste_1 = liste_couples(1000,50,1080)

liste_couples_1 = open("liste_couples_sujets_50.csv","w")

for i in range(1000):
    print(i)
    for j in range(2):
        for k in range(50):
            liste_couples_1.write(str(liste_1[i][j][k]))
            if (k != 49 or j!= 1):
                liste_couples_1.write(", ")
    liste_couples_1.write("\n")
liste_couples_1.close()


def intersection(l1,l2):
    l3 = [x for x in l1 if x in l2]
    return l3

def intersect_liste(l_l):
    l = []
    for i in l_l:
        for k in i:
            if not(k in l):
                l.append(k)
    return l


def overlap(e,s,n):
    liste = gen_liste(e,s,n)
    n = 0
    m = 0
    l0 = liste[0]
    l1 = liste[1]
    nb_couples = 0
    for i in range(e):
        for j in range(i-1):
            k = len(intersection(liste[i],liste[j]))
            m = m + k
            if (k > 0):
                nb_couples = nb_couples + 1
            if (k > n):
                n = k
                l0 = liste[i]
                l1 = liste[j]
    m2 = m/(e*(e-1)/2)
    prop_couples = nb_couples/(e*(e-1)/2)
    return (m2,prop_couples,n,l0,l1)
