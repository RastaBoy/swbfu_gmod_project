AddCSLuaFile()

net.Receive("SelectClass", function()
    print("Slect Class NOW!")
    local classesTable = net.ReadTable()
    PrintTable(classesTable)
    ClassSelectorDraw(classesTable)
end)