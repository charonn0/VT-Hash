#tag Class
Protected Class VTSocket
Inherits HTTPSecureSocket
	#tag Method, Flags = &h0
		Function SendRequest(URL As String, Request As JSONItem) As JSONItem
		  dim formData As New Dictionary
		  For Each Name As String In Request.Names
		    formData.Value(Name) = Request.Value(Name)
		  Next
		  me.SetFormData(formData)
		  me.SetRequestHeader("User-Agent", "VTHash/" + version + " (Not at all like Mozilla)")
		  Window1.ProgressBar1.Value = 5
		  Dim s As String = me.Post(URL, 5)
		  Return New JSONItem(s)
		End Function
	#tag EndMethod


End Class
#tag EndClass
