
#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)	

	ДобавитьСтрокуКомментарии(ВыбранноеЗначение);
	
	СформироватьОсновнойТекст();
	
	Модифицированность = Истина;
КонецПроцедуры

 &НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
 	Если Объект.Комментарии.Количество() = 0 Тогда
 		ДобавитьНачальнуюСтраницуHTML();	
 	КонецЕсли;	
 	
 	СформироватьОсновнойТекст();
 КонецПроцедуры

#КонецОбласти
 
#Область  ОбработчикиСобытийЭлементовТаблицыФормыКомментарии
&НаКлиенте
Процедура КомментарииВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Если Не Поле.Имя = "КомментарииКартинка" Тогда
		СтрутураПараметров = Новый Структура;
		ТекСтрока = Элементы.Комментарии.ТекущиеДанные;
		СтрутураПараметров.Вставить("Комментарий", 		текСтрока.Комментарий);
		СтрутураПараметров.Вставить("Тэг", 				текСтрока.Тэг);
		СтрутураПараметров.Вставить("НомерСтроки",		текСтрока.НомерСтроки);	
		
		ОткрытьФорму("Справочник.Ленты.Форма.ФормаВводаТекста", СтрутураПараметров, ЭтотОбъект);
	КонецЕсли;
КонецПроцедуры
#КонецОбласти

 #Область ОбработчикиКомандФормы
&НаКлиенте
Процедура КомандаВвестиТекст(Команда)
	ОткрытьФорму("Справочник.Ленты.Форма.ФормаВводаТекста",,ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьФайл(Команда)
	ДобавитьФайлы();
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьФайлНовыйВариант(Команда)
	Фильтр = "Все картинки (*.bmp;*.dib;*.rle;*.jpg;*.jpeg;*.tif;*.gif;*.png;*.ico;*.wmf;*.emf)|*.bmp;*.dib;*.rle;*.jpg;*.jpeg;*.tif;*.gif;*.png;*.ico;*.wmf;*.emf|" 
	+ "Формат bmp (*.bmp;*.dib;*.rle)|*.bmp;*.dib;*.rle|"
	+ "Формат JPEG (*.jpg;*.jpeg)|*.jpg;*.jpeg|"
	+ "Формат TIFF (*.tif)|*.tif|"
	+ "Формат GIF (*.gif)|*.gif|"
	+ "Формат PNG (*.png)|*.png|"
	+ "Формат icon (*.ico)|*.ico|"
	+ "Формат метафайл (*.wmf;*.emf)|*.wmf;*.emf|";
	
	Диалог = новый ПараметрыДиалогаПомещенияФайлов("Выберите файл картинки", Ложь, Фильтр);
		
	Оповещение = новый ОписаниеОповещения("ПослеЗакрытияДиалогаВыбора", ЭтотОбъект);
	
	НачатьПомещениеФайлаНаСервер(Оповещение,,,, Диалог, УникальныйИдентификатор);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
 &НаСервере
Процедура СформироватьОсновнойТекст()
	Объект.ОсновнойТекст = "";
	Для Каждого СтрокаТЧ Из Объект.Комментарии Цикл
		Если ЗначениеЗаполнено(СтрокаТЧ.Тэг) Тогда
			//@skip-check reading-attribute-from-database
			Если СтрокаТЧ.Тэг.Одиночный Тогда
				Если ЗначениеЗаполнено(СтрокаТЧ.Картинка) Тогда
					ТекКартинка = ПолучитьНавигационнуюСсылку(СтрокаТЧ.Картинка, "ФайлХранилище");
					Если ЗначениеЗаполнено(СтрокаТЧ.Комментарий) Тогда
						ТекстДляВставки = "<img src=" + ТекКартинка + " width=""50"" height=""50"" >";
					Иначе
						Высота = ? (СтрокаТЧ.Высота = 0, 300, СтрокаТЧ.Высота);
						Ширина = ? (СтрокаТЧ.Ширина = 0, 400, СтрокаТЧ.Ширина);
						ТекстДляВставки = "<p></p>" + "<img src=" + ТекКартинка + " width=" + Ширина + "height=" + Высота + " >";
					КонецЕсли;
				Иначе
					ТекстДляВставки = "<" + СтрокаТЧ.Тэг.Наименование + ">" + СтрокаТЧ.Комментарий;	
				КонецЕсли;
			Иначе
				ТекстДляВставки = "<" + СтрокаТЧ.Тэг.Наименование + ">" + СтрокаТЧ.Комментарий + "</" + СтрокаТЧ.Тэг.Наименование + ">";
			КонецЕсли;	
			ТекстДляВставки = СтрЗаменить(ТекстДляВставки, Символы.ПС, "<br>");
			Объект.ОсновнойТекст = Объект.ОсновнойТекст + ТекстДляВставки;
		Иначе
			Объект.ОсновнойТекст = Объект.ОсновнойТекст + СтрокаТЧ.Комментарий;
		КонецЕсли;
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
 	 
 	НоваяСтрока.Комментарий = ТекстКоментария;
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
 	
 	НоваяСтрока.Комментарий = ТекстКоментария; 
 КонецПроцедуры
 
 &НаКлиенте
Процедура ДобавитьФайлы()
	УИД 		= Новый УникальныйИдентификатор();
	Оповещение  = Новый ОписаниеОповещения("ОбработатьВыборФайла",   ЭтотОбъект);
	НачатьПомещениеФайла(Оповещение,   ,   ,   Истина,   УИД);
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьВыборФайла(Результат, Адрес, ВыбранноеИмяФайла, ДополнительныеПараметры) Экспорт
	
	Если Не Результат Тогда
		Возврат; 
	КонецЕсли;
	
	ОписаниеФайла = Новый Файл(ВыбранноеИмяФайла);
	
	СсылкаНаОбъект = Объект.Ссылка; 
	СохранитьФайлВХранилище(Адрес, СсылкаНаОбъект, ОписаниеФайла.ИмяБезРасширения);	
 	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗакрытияДиалогаВыбора (ОписаниеФайла, ДопПараметры) Экспорт
	
	Если ОписаниеФайла.ПомещениеФайлаОтменено Тогда
		Возврат;
	КОнецЕсли;
	
	СсылкаНаОбъект = Объект.Ссылка; 
	СсылкаФайл = СохранитьФайлВХранилище(ОписаниеФайла.Адрес, СсылкаНаОбъект, ОписаниеФайла.СсылкаНаФайл.Файл.ИмяБезРасширения);	
	
	НоваяСтрока = Объект.Комментарии.Добавить();
	НоваяСтрока.Картинка = СсылкаФайл;
	НоваяСтрока.Тэг = ПолучитьТэгКартинки();
	
	Объект.Комментарии.Сдвинуть(ПолучитьКоличествоСтрокКомментариев() - 1, -1);
	
КонецПроцедуры

&НаСервере
Функция ПолучитьТэгКартинки()	
	Возврат Справочники.Тэги.НайтиПоНаименованию("img");	
КонецФункции

&НаСервере
Функция ПолучитьКоличествоСтрокКомментариев()
	Возврат Объект.Комментарии.Количество();
КонецФункции

&НаСервере
Функция СохранитьФайлВХранилище(Адрес, Владелец, Имя)

	НовФайл = Справочники.ЛентыФайлы.СоздатьЭлемент();
	НовФайл.ВладелецФайла 		= Владелец;
	НовФайл.Наименование 		= Имя;
	НовФайл.ДатаСоздания 		= ТекущаяДатаСеанса();
	НовФайл.ФайлХранилище 		= Новый ХранилищеЗначения(ПолучитьИзВременногоХранилища(Адрес));
	НовФайл.Записать();
	
	Возврат НовФайл.Ссылка;
КонецФункции
 
&НаКлиенте
Процедура ДобавитьСтрокуКомментарии(ВыбранноеЗначение)
	
	НомерСтроки = ВыбранноеЗначение.НомерСтроки;
	Если НомерСтроки > 0 Тогда
		НоваяСтрока = Элементы.Комментарии.ТекущиеДанные; 
	Иначе	
		НоваяСтрока = Объект.Комментарии.Добавить();
	КонецЕсли;
	
	НоваяСтрока.Комментарий = ВыбранноеЗначение.ВведенныйТекст;
	НоваяСтрока.Тэг 		= ВыбранноеЗначение.Тэг;
	
	Если НомерСтроки = 0 Тогда
		Объект.Комментарии.Сдвинуть(ПолучитьКоличествоСтрокКомментариев() - 1, -1);	
	КонецЕсли;
	
КонецПроцедуры
	
#КонецОбласти