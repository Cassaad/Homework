Sub StockMarket()

Dim ws As Worksheet
Dim ws_destination As Worksheet
Dim Ticker As String
Dim Total_Volume As Double
Dim Total_Change As Double
Dim Summary_Row As Integer
Dim lRow As Long
Dim counter As Double
Dim average_change As Double
Dim Closing_Value As Double                        ' to calculate % change as difference between openings and closing over closing
Dim Change_Percentage As Double


Set ws_destination = ThisWorkbook.Sheets("New Sheet")
Set ws = ThisWorkbook.Sheets("2016")
With ws
lRow = .Range("A" & .Rows.count).End(xlUp).Row
End With

counter = 0
Total_Volume = 0
Total_Change = 0
Change_Percentage = 0
Closing_Value = 0
Summary_Row = 2

For i = 2 To lRow
 
 If Sheets("2016").Cells(i + 1, 1).Value <> Sheets("2016").Cells(i, 1).Value Then
 
 counter = counter + 1
 Ticker = Sheets("2016").Cells(i, 1).Value
 Total_Volume = Total_Volume + Sheets("2016").Cells(i, 7).Value
 Total_Change = Total_Change + (Sheets("2016").Cells(i, 6).Value - Sheets("2016").Cells(i, 3).Value)
 average_change = Total_Change / counter
 Closing_Value = Closing_Value + Sheets("2016").Cells(i, 6).Value
 Change_Percentage = Total_Change / (Closing_Value / counter)    'Total change between opening and closing price over the average of closing Price
 
 Sheets("2016").Range("I" & Summary_Row).Value = Ticker
 Sheets("2016").Range("J" & Summary_Row).Value = Total_Volume
 Sheets("2016").Range("K" & Summary_Row).Value = Total_Change
 Sheets("2016").Range("L" & Summary_Row).Value = average_change
 Sheets("2016").Range("M" & Summary_Row).Value = Change_Percentage
 
 Columns("M:M").Select
 Selection.Style = "Percent"
 
 
 Summary_Row = Summary_Row + 1
 
 Total_Volume = 0
 Total_Change = 0
 counter = 0
 Closing_Value = 0
 Change_Percentage = 0
 
 Else
 counter = counter + 1
 Total_Volume = Total_Volume + Sheets("2016").Cells(i, 7).Value
 Total_Change = Total_Change + (Sheets("2016").Cells(i, 6).Value - Sheets("2016").Cells(i, 3).Value)
 average_change = Total_Change / counter
 Closing_Value = Closing_Value + Sheets("2016").Cells(i, 6).Value
 Change_Percentage = Total_Change / (Closing_Value / counter)
 
 End If

Next i


Sheets("2016").Columns("I:I").copy Sheets("New Sheet").Columns("A:A")
Sheets("2016").Columns("K:K").copy Sheets("New Sheet").Columns("B:B")
Sheets("2016").Columns("J:J").copy Sheets("New Sheet").Columns("E:E")
Sheets("2016").Columns("L:L").copy Sheets("New Sheet").Columns("D:D")
Sheets("2016").Columns("M:M").copy Sheets("New Sheet").Columns("C:C")


' To Format Total Change in Stock

Dim rCell As Range
Dim rRng As Range
Set rRng = Sheets("New Sheet").Range("B2:B3169")
For Each rCell In rRng.Cells
       
 If rCell.Value >= 0 Then
 rCell.Interior.ColorIndex = 10
 Else
 rCell.Interior.ColorIndex = 3
 End If

Next rCell

End Sub
Sub Finding_MaxVolume()

Dim WorkRange As Range
Dim rFound As Range
Dim MaxVal As Double
Dim Ticker As String
 
Set WorkRange = Sheets("New Sheet").Range("E:E")
 
MaxVal = Application.Max(WorkRange)
Sheets("New Sheet").Range("J2").Value = MaxVal
 
With WorkRange
    Application.Goto .Range("A" & WorksheetFunction.Match(MaxVal, .Columns(1), 0))
End With

End Sub
Sub Finding_MaxChange()

Dim WorkRange As Range
Dim rFound As Range
Dim Ticker As String
Dim MaxPercentage As Double
 
Set WorkRange = Sheets("New Sheet").Range("C:C")
 
MaxPercentage = Application.Max(WorkRange)
Sheets("New Sheet").Range("J4").Value = MaxPercentage
 
With WorkRange
    Application.Goto .Range("A" & WorksheetFunction.Match(MaxPercentage, .Columns(1), 0))
End With

End Sub

Sub Finding_MaxAverage()

Dim WorkRange As Range
Dim rFound As Range
Dim Ticker As String
Dim MaxAverage As Double

 
Set WorkRange = Sheets("New Sheet").Range("D:D")
 
MaxAverage = Application.Max(WorkRange)
Sheets("New Sheet").Range("J6").Value = MaxAverage
 
With WorkRange
    Application.Goto .Range("A" & WorksheetFunction.Match(MaxAverage, .Columns(1), 0))
End With

End Sub


