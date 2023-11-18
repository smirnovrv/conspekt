#Область ОбработчикиСобытийФормы
&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)	
	НоваяСтрока = Объект.Комментарии.Добавить();
	НоваяСтрока.Коментарий = ВыбранноеЗначение.ВведенныйТекст;
	
	КоличествоСтрок = Объект.Комментарии.Количество();
	Объект.Комментарии.Сдвинуть(КоличествоСтрок - 1, -1);	
КонецПроцедуры

 &НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
 	Если Объект.Комментарии.Количество() = 0 Тогда
 		ДобавитьНачальнуюСтраницуHTML();	
 	КонецЕсли;	
 	
 	СформироватьОсновнойТекст()
 КонецПроцедуры
 
#КонецОбласти
 
 #Область ОбработчикиКомандФормы
&НаКлиенте
Процедура КомандаВвестиТекст(Команда)
	ОткрытьФорму("Справочник.Ленты.Форма.ФормаВводаТекста",,ЭтотОбъект);
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
 &НаСервере
 Процедура СформироватьОсновнойТекст()
 	Объект.ОсновнойТекст = "";
 	Для Каждого СтрокаТЧ Из Объект.Комментарии Цикл
 		Объект.ОсновнойТекст = Объект.ОсновнойТекст + СтрокаТЧ.Коментарий;
 	КонецЦикла;	
 КонецПроцедуры

 &НаСервере
 Процедура ДобавитьНачальнуюСтраницуHTML()
 	ДобавитьНачалоHTML();	
 	ДобавитьКонецHTML();
 КонецПроцедуры

 &НаСервере
 Процедура ДобавитьКонецHTML()
 	НоваяСтрока = Объект.Комментарии.Добавить();
 	
 	ТекстКоментария =	"	</body>";
 	ТекстКоментария = ТекстКоментария + Символы.ПС + "</html>";
 	 
 	НоваяСтрока.Коментарий = ТекстКоментария;
 КонецПроцедуры

 &НаСервере
 Процедура ДобавитьНачалоHTML()
 	НоваяСтрока = Объект.Комментарии.Добавить();
 	
 	ТекстКоментария = "<!DOCTYPE html>"; 
 	ТекстКоментария = ТекстКоментария + Символы.ПС + "<html lang=""ru>";
 	ТекстКоментария = ТекстКоментария + Символы.ПС + "	<head>";
 	ТекстКоментария = ТекстКоментария + Символы.ПС + "		<meta charset=""UTF-8>";
 	ТекстКоментария = ТекстКоментария + Символы.ПС + "		 <title>" + Объект.Наименование + "</title>";
 	ТекстКоментария = ТекстКоментария + Символы.ПС + "	</head>";
 	ТекстКоментария = ТекстКоментария + Символы.ПС + "	<body>";
 	
 	НоваяСтрока.Коментарий = ТекстКоментария; 
 КонецПроцедуры
 
#КонецОбласти