Imports ADODB
Imports System.Data.Odbc

Module Module1

    Sub Main()

        Dim con = New ADODB.Connection()
        With con
            .Open("Provider=MSDASQL;DRIVER={MySQL ODBC 8.0 ANSI Driver}; SERVER=localhost;DATABASE=sys;UID=root;PWD=1234")
            .Execute("CREATE DATABASE IF NOT EXISTS shverdiakov_lab2;")
            .Execute("USE shverdiakov_lab2")
            .Execute("CREATE TABLE IF NOT EXISTS Owners (idOwner INT PRIMARY KEY AUTO_INCREMENT, Owner VARCHAR(50), Gr VARCHAR(50));")
            .Close()
        End With

        Dim connectionString As String = "Driver={MySQL ODBC 8.0 ANSI Driver};Server=localhost;Database=shverdiakov_lab2;User=root;Password=1234;Option=3;"
        Using conn As New OdbcConnection(connectionString)
            conn.Open()

            Using command As New OdbcCommand("INSERT INTO Owners (Owner, Gr) VALUES (?, ?)", conn)
                command.Parameters.AddWithValue("Owner", "Швердяков")
                command.Parameters.AddWithValue("Gr", "A-06-21")
                command.ExecuteNonQuery()

                command.Parameters.AddWithValue("Owner", "Щевелева")
                command.Parameters.AddWithValue("Gr", "A-06-21")
                command.ExecuteNonQuery()

                command.Parameters.AddWithValue("Owner", "Мащенок")
                command.Parameters.AddWithValue("Gr", "A-13-21")
                command.ExecuteNonQuery()

                command.Parameters("Owner").Value = "Лопатина"
                command.Parameters("Gr").Value = "A-01-21"
                command.ExecuteNonQuery()
            End Using

            conn.Close()
        End Using
        Console.Write("База данных создана!")
        Threading.Thread.Sleep(2000)
        Console.readkey() 

    End Sub
End Module
