
#Область ОбработчикиСобытийФормы
&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	Если ЗначениеЗаполнено(ВведенныйТекст) Тогда
		СтруктураПараметров = Новый Структура("ВведенныйТекст, Тэг, НомерСтроки, Якорь, Вставка", ВведенныйТекст, Тэг, НомерСтроки, Якорь, ЭтоВставка);
		ОповеститьОВыборе(СтруктураПараметров);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Комментарий") Тогда
		ВведенныйТекст = Параметры.Комментарий;
	КонецЕсли;
	
	Если Параметры.Свойство("Тэг") Тогда
		Тэг = Параметры.Тэг;
	КонецЕсли;
	
	Если Параметры.Свойство("НомерСтроки") Тогда
		НомерСтроки = Параметры.НомерСтроки;
	КонецЕсли;

	Если Параметры.Свойство("Якорь") Тогда
		Якорь = Параметры.Якорь; 
	КонецЕсли; 
	
	Если Параметры.Свойство("Вставка") Тогда
		ЭтоВставка = Параметры.Вставка; 
	КонецЕсли; 
	
	Если Не ЗначениеЗаполнено(Тэг) Тогда
		Тэг = Справочники.Тэги.НайтиПоКоду("000000007");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	ВведенныйТекст = СтрЗаменить(ВведенныйТекст, ВыбранноеЗначение.ТекстДо, ВыбранноеЗначение.ТекстПосле); 
КонецПроцедуры
	
#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаРедактировать(Команда)		
	СтрутураПараметров = Новый Структура;
	ВыделенныйТекст = Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст;
	СтрутураПараметров.Вставить("Комментарий", 		ВыделенныйТекст); 	
		
	ОткрытьФорму("Справочник.Ленты.Форма.ФормаВводаТекста", СтрутураПараметров, ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура КомандаЖирный(Команда)
	ВыделенныйТекст = Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст;
	ТекстВставки = ВыделенныйТекст;
	ТекстВставки = ОбщийHTMLКлиент.КомандаЖирный(ТекстВставки); 
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = "";
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = ТекстВставки;	
КонецПроцедуры

&НаКлиенте
Процедура КомандаКурсив(Команда)
	ВыделенныйТекст = Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст;
	ТекстВставки = ВыделенныйТекст;
	ТекстВставки = ОбщийHTMLКлиент.КомандаКурсив(ТекстВставки); 
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = "";
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = ТекстВставки;	
КонецПроцедуры

&НаКлиенте
Процедура КомандаПеречеркнутый(Команда)
	ВыделенныйТекст = Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст;
	ТекстВставки = ВыделенныйТекст;
	ТекстВставки = ОбщийHTMLКлиент.КомандаПеречеркнутый(ТекстВставки); 
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = "";
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = ТекстВставки;
КонецПроцедуры

&НаКлиенте
Процедура КомандаПодчеркнутый(Команда)
	ВыделенныйТекст = Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст;
	ТекстВставки = ВыделенныйТекст;
	ТекстВставки = ОбщийHTMLКлиент.КомандаПодчеркнутый(ТекстВставки); 
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = "";
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = ТекстВставки;
КонецПроцедуры

&НаКлиенте
Процедура КомандаРазрывСтроки(Команда)
	ВыделенныйТекст = Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст;
	ТекстВставки = ВыделенныйТекст;
	ТекстВставки = ОбщийHTMLКлиент.КомандаРазрывСтроки(ТекстВставки); 
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = "";
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = ТекстВставки;
КонецПроцедуры

&НаКлиенте
Процедура КомандаЛиния(Команда)
	ВведенныйТекст = "<hr>";
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗнакМеньше(Команда)
	ТекстВставки = "&lt ";
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = "";
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = ТекстВставки;
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗнакБольше(Команда)
	ТекстВставки = " &gt";
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = "";
	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = ТекстВставки;
КонецПроцедуры

&НаКлиенте
Процедура КомандаСоздатьНумерованныйСписок(Команда)
//	ТекстВставки = "<ol> <li></li> </ol>";
//	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = "";
//	Элементы.ВведенныйТекстРасширеннаяПодсказка.Родитель.ВыделенныйТекст = ТекстВставки;
КонецПроцедуры
#КонецОбласти