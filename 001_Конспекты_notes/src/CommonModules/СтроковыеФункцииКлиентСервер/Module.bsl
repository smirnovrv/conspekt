#Область СлужебныеПроцедурыИФункции
// Определяет, является ли символ разделителем.
//
// Параметры:
//  КодСимвола      - Число  - код проверяемого символа;
//  РазделителиСлов - Строка - символы разделителей. Если параметр не указан, то 
//                             разделителем считаются все символы, не являющиеся цифрами, 
//                             латинскими и кириллическими буквами, а также знаком подчеркивания.
//
// Возвращаемое значение:
//  Булево - Истина, если символ с кодом КодСимвола является разделителем.
//
Функция ЭтоРазделительСлов(КодСимвола, РазделителиСлов = Неопределено) Экспорт
	
	Если РазделителиСлов <> Неопределено Тогда
		Возврат СтрНайти(РазделителиСлов, Символ(КодСимвола)) > 0;
	КонецЕсли;
		
	Диапазоны = Новый Массив;
	ПриОпределенииСимволовСлов(Диапазоны);
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 48, 57)); 	// цифры
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 65, 90)); 	// латиница большие
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 97, 122)); 	// латиница маленькие
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 95, 95)); 	// символ "_"
	
	Для Каждого Диапазон Из Диапазоны Цикл
		Если КодСимвола >= Диапазон.Мин И КодСимвола <= Диапазон.Макс Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

// Определяет коды символов, которые не считаются разделителем.
// Если явно не указан разделитель слов.
//
// Параметры:
//   Диапазоны - Массив из Структура:
//    * Мин - Число - код символа, с которого начинается диапазон.
//    * Макс - Число - код символа, на котором заканчивается диапазон.
//
Процедура ПриОпределенииСимволовСлов(Диапазоны) Экспорт
	// Локализация
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 1040, 1103));  // кириллица
	// АПК:163-выкл
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 1025, 1025));  // символ "Ё"
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 1105, 1105));  // символ "ё"
	// АПК:163-вкл
	
	// Конец Локализация
КонецПроцедуры

// Разбивает строку на несколько строк, используя заданный набор разделителей.
// Если параметр РазделителиСлов не задан, то разделителем слов считается любой из символов, 
// не относящихся к символам латиницы, кириллицы, цифры, подчеркивания.
//
// Параметры:
//  Значение        - Строка - исходная строка, которую необходимо разложить на слова.
//  РазделителиСлов - Строка - перечень символов-разделителей. Например, ".,;".
//
// Возвращаемое значение:
//  Массив - список слов.
//
// Пример:
//  СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивСлов("один-@#два2_!три") возвратит массив значений: "один",
//  "два2_", "три"; СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивСлов("один-@#два2_!три", "#@!_") возвратит массив
//  значений: "один-", "два2", "три".
//
Функция РазложитьСтрокуВМассивСлов(Знач Значение, РазделителиСлов = Неопределено) Экспорт
	
	Слова = Новый Массив;
	
	РазмерТекста = СтрДлина(Значение);
	НачалоСлова = 1;
	Для Позиция = 1 По РазмерТекста Цикл
		КодСимвола = КодСимвола(Значение, Позиция);
		Если ЭтоРазделительСлов(КодСимвола, РазделителиСлов) Тогда
			Если Позиция <> НачалоСлова Тогда
				Слова.Добавить(Сред(Значение, НачалоСлова, Позиция - НачалоСлова));
			КонецЕсли;
			НачалоСлова = Позиция + 1;
		КонецЕсли;
	КонецЦикла;
	
	Если Позиция <> НачалоСлова Тогда
		Слова.Добавить(Сред(Значение, НачалоСлова, Позиция - НачалоСлова));
	КонецЕсли;
	
	Возврат Слова;
	
КонецФункции
#КонецОбласти

