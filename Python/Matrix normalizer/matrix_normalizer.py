class Matrix:
    def __init__(self) -> None:
        self.matrix = []
        self.res = 0
        with open("matrix.txt", 'r') as f:
            for line in f:
                if line != "STOP\n":
                    numbers = [float(n) for n in line.split()]
                    self.matrix.append(numbers)
                else:
                    break

    def printSelf(self):
        for i in self.matrix:
            print(i)
        print()
        return

    def addRows(self, r1, r2):
        for i in range(len(self.matrix[r1 - 1])):
            self.matrix[r1 - 1][i] += self.matrix[r2 - 1][i]
        return

    def subRows(self, r1, r2):
        for i in range(len(self.matrix[r1 - 1])):
            self.matrix[r1 - 1][i] -= self.matrix[r2 - 1][i]
        return

    def multiRows(self, r1, r2):
        for i in range(len(self.matrix[r1 - 1])):
            self.matrix[r1 - 1][i] *= self.matrix[r2 - 1][i]
        return

    def multiRow(self, r, n):
        for i in range(len(self.matrix[r - 1])):
            self.matrix[r - 1][i] *= n
        return

    def divRow(self, r, n):
        for i in range(len(self.matrix[r - 1])):
            self.matrix[r - 1][i] /= n
        return

    def swapRows(self, r1, r2):
        self.matrix[r1 - 1], self.matrix[r2 - 1] = self.matrix[r2 - 1], self.matrix[r1 - 1]

    # If you want to see the process clearer uncomment the prints below
    def toRREF(self):
        lead = 0
        rows = len(self.matrix)
        columns = len(self.matrix[0])

        for i in range(rows):
            # print("before")
            # self.printSelf()
            if columns <= lead:
                # print("lead exceeded column count")
                return
            
            n1 = i
            
            while self.matrix[n1][lead] == 0:
                # print("self.matrix[n1][lead] is NOT equal to 0")
                n1 += 1
                if n1 == rows:
                    n1 = i
                    lead += 1
                    if columns == lead:
                        # print("lead equals column count")
                        return
                    # self.printSelf()
                    # print("^ after ^")
            
            # print("swapping and dividing")
            self.swapRows(n1 + 1, i + 1)
            div = self.matrix[i][lead]
            self.divRow(i + 1, float(div))
            # self.printSelf()
            # print("^ after ^")
            
            for n2 in range(rows):
                if n2 != i:
                    # print("n2 is NOT equal to i")
                    # print("multiplying and subbing")
                    div = self.matrix[n2][lead]
                    if div == 0:
                        self.res = 1
                        return 1
                    self.multiRow(i + 1, div)
                    # self.printSelf()
                    # print("^ after ^")
                    # print("subbing")
                    self.subRows(n2 + 1, i + 1)
                    self.multiRow(i + 1, 1 / div)
                    # self.printSelf()
                    # print("^ after ^")

            lead += 1
            # print("after")
            # print("lead:", lead, "i:", i, "n2:", n2)
            # self.printSelf()
            # print()

    # no commented prints, easier to read code version
    def toRREFnoComments(self):
        lead = 0
        rows = len(self.matrix)
        columns = len(self.matrix[0])

        for i in range(rows):
            if columns <= lead:
                return
            
            n1 = i
            
            while self.matrix[n1][lead] == 0:
                n1 += 1
                if n1 == rows:
                    n1 = i
                    lead += 1
                    if columns == lead:
                        return
            
            self.swapRows(n1 + 1, i + 1)
            div = self.matrix[i][lead]
            self.divRow(i + 1, float(div))
            
            for n2 in range(rows):
                if n2 != i:
                    div = self.matrix[n2][lead]
                    self.multiRow(i + 1, div)
                    self.subRows(n2 + 1, i + 1)
                    self.multiRow(i + 1, 1 / div)

            lead += 1

    def checkResult(self):
        if self.res != 1:
            vars = []
            ress = []
            retstr = ""
            for i in self.matrix:
                for j in range(len(i)):
                    if j == len(i) - 1:
                        ress.append(i[j])
                    elif i[j] == 1:
                        vars.append(i[j])
                    elif i[j] != 0:
                        print("No solutions")
                        return -1
            for i in range(len(ress)):
                retstr += ("x" + str(i + 1) + " = " + str(ress[i]) + "; ")
            print("One solution:", retstr)
            return 0
        else:
            print("Infinite solutions")
            return 1

m = Matrix()
m.printSelf()
m.toRREF()
m.printSelf()
m.checkResult()