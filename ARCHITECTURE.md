# تطبيق البطاقات التعليمية - FlashCard App

## نظرة عامة

تطبيق Android حديث للفلاش كارد التعليمية يستخدم نظام التكرار المتباعد (Spaced Repetition) لمساعدة المستخدمين على حفظ الأسئلة والأجوبة بذكاء وكفاءة.

## التقنيات المستخدمة

- **Kotlin**: لغة البرمجة الأساسية
- **Jetpack Compose**: لبناء واجهات المستخدم الحديثة
- **Material Design 3**: لتصميم عصري وأنيق
- **Room Database**: لتخزين البيانات محلياً
- **MVVM Architecture**: لهيكلة نظيفة وقابلة للتوسعة
- **Coroutines & Flow**: للبرمجة غير المتزامنة
- **Navigation Component**: للتنقل بين الشاشات
- **ViewModel**: لإدارة بيانات الواجهة

## هيكلة المشروع

```
app/src/main/java/com/flashcard/app/
├── data/                          # طبقة البيانات
│   ├── local/                    # قاعدة البيانات المحلية
│   │   ├── dao/                  # واجهات الوصول للبيانات
│   │   │   ├── FlashcardDao.kt
│   │   │   └── GroupDao.kt
│   │   ├── entity/               # كيانات قاعدة البيانات
│   │   │   ├── FlashcardEntity.kt
│   │   │   └── GroupEntity.kt
│   │   └── FlashcardDatabase.kt
│   └── repository/               # طبقة المستودع
│       ├── FlashcardRepository.kt
│       └── ImportExportRepository.kt
├── domain/                       # طبقة الأعمال
│   ├── algorithm/                # الخوارزميات
│   │   └── SpacedRepetitionAlgorithm.kt
│   └── model/                    # نماذج المجال
│       ├── Flashcard.kt
│       └── Group.kt
├── ui/                          # طبقة الواجهة
│   ├── screen/                  # الشاشات
│   │   ├── HomeScreen.kt
│   │   ├── FlashcardListScreen.kt
│   │   ├── StudyScreen.kt
│   │   ├── ExamScreen.kt
│   │   └── StatisticsScreen.kt
│   ├── theme/                   # الثيمات والألوان
│   │   ├── Theme.kt
│   │   └── Type.kt
│   └── viewmodel/               # نماذج العرض
│       ├── GroupViewModel.kt
│       ├── FlashcardViewModel.kt
│       ├── StudyViewModel.kt
│       ├── ExamViewModel.kt
│       ├── StatisticsViewModel.kt
│       └── ViewModelFactory.kt
├── navigation/                  # التنقل
│   ├── AppNavigation.kt
│   └── Screen.kt
├── di/                         # حقن التبعية
│   └── AppModule.kt
└── MainActivity.kt
```

## المميزات الرئيسية

### 1. نظام المجموعات (Groups)
- إنشاء/تعديل/حذف مجموعات
- كل مجموعة تحتوي على بطاقات تعليمية خاصة بها
- عرض عدد البطاقات داخل كل مجموعة
- إمكانية اختيار مجموعة أو عدة مجموعات للامتحان

### 2. البطاقات التعليمية (Flashcards)
- إنشاء بطاقات بالسؤال والجواب
- خيار إنشاء بطاقة معكوسة تلقائياً
- تعديل وحذف البطاقات
- البحث داخل البطاقات

### 3. وضع الدراسة (Study Mode)
- اختيار عدد البطاقات المراد دراستها (3، 5، 10، 20)
- مراجعة البطاقات بشكل متكرر
- حركة قلب البطاقة سلسة (Flip Animation)
- عداد يوضح التقدم
- تقييم صعوبة كل بطاقة (سهل، متوسط، صعب)
- الانتقال للدفعة التالية بعد الانتهاء

### 4. وضع الامتحان (Exam Mode)
- اختيار مجموعة أو عدة مجموعات
- عرض الأسئلة بشكل ذكي حسب مستوى الصعوبة
- نظام تقييم (صحيح/خطأ)
- عرض النتيجة النهائية بالنسبة المئوية

### 5. خوارزمية التكرار الذكي (Spaced Repetition)

#### آلية العمل:
- **الأسئلة الصعبة**: تتكرر كثيراً (فترات قصيرة)
  - أول مراجعة: 10 دقائق
  - معامل الزيادة: 1.2x
  
- **الأسئلة المتوسطة**: تتكرر أحياناً (فترات متوسطة)
  - أول مراجعة: 1 يوم
  - معامل الزيادة: 1.5x
  
- **الأسئلة السهلة**: تظهر نادراً (فترات طويلة)
  - أول مراجعة: 3 أيام
  - معامل الزيادة: 2.5x

#### حساب الأولوية:
```kotlin
Priority = Difficulty × (1 / (1 + TimeUntilReview))
```

الأسئلة المتأخرة أو الصعبة تحصل على أولوية أعلى للظهور.

### 6. الإحصائيات
- عدد المجموعات والبطاقات
- توزيع البطاقات حسب الصعوبة
- معدل النجاح
- إجمالي المراجعات
- رسوم بيانية تفاعلية

### 7. التصميم (UI/UX)
- Material Design 3
- دعم الوضع الليلي تلقائياً
- دعم كامل للعربية (RTL)
- أنيميشن سلسة لقلب البطاقات
- واجهات بسيطة ومريحة للعين

### 8. استيراد وتصدير البيانات
- تصدير جميع البيانات بصيغة JSON
- استيراد البيانات من ملف
- نسخ احتياطي سهل

## قاعدة البيانات

### جدول Groups
```sql
CREATE TABLE groups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    createdAt INTEGER NOT NULL,
    cardCount INTEGER DEFAULT 0
)
```

### جدول Flashcards
```sql
CREATE TABLE flashcards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    groupId INTEGER NOT NULL,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    difficulty INTEGER DEFAULT 1,
    nextReviewDate INTEGER NOT NULL,
    reviewCount INTEGER DEFAULT 0,
    isReversed BOOLEAN DEFAULT 0,
    createdAt INTEGER NOT NULL,
    lastReviewedAt INTEGER DEFAULT 0,
    FOREIGN KEY(groupId) REFERENCES groups(id) ON DELETE CASCADE
)
```

## كيفية الاستخدام

### 1. إنشاء مجموعة جديدة
1. افتح التطبيق
2. اضغط على زر + في الأسفل
3. أدخل اسم المجموعة والوصف (اختياري)
4. اضغط "إنشاء"

### 2. إضافة بطاقات
1. اضغط على المجموعة
2. اضغط على زر +
3. أدخل السؤال والجواب
4. اختر "إنشاء بطاقة معكوسة" إذا أردت
5. اضغط "إنشاء"

### 3. الدراسة
1. من الشاشة الرئيسية، اضغط على أيقونة التشغيل بجانب المجموعة
2. اختر عدد البطاقات (3، 5، 10، 20)
3. اضغط على البطاقة لقلبها وإظهار الجواب
4. قيّم الصعوبة (سهل، متوسط، صعب)
5. انتقل للبطاقة التالية
6. بعد الانتهاء، اضغط "الدفعة التالية" للمزيد

### 4. الامتحان
1. اضغط على أيقونة School في الأعلى
2. اختر مجموعة أو أكثر
3. اضغط "بدء الامتحان"
4. اقرأ السؤال واضغط "إظهار الجواب"
5. قيّم إجابتك (صحيح/خطأ)
6. شاهد نتيجتك النهائية

## الخوارزمية بالتفصيل

### حساب موعد المراجعة القادمة
```kotlin
fun calculateNextReview(flashcard, newDifficulty): Long {
    if (reviewCount == 0) {
        // أول مراجعة
        return currentTime + INITIAL_INTERVAL[difficulty]
    } else {
        // مراجعات لاحقة
        interval = baseInterval × multiplier[difficulty]
        return currentTime + min(interval, MAX_INTERVAL)
    }
}
```

### اختيار البطاقات للدراسة
1. حساب الأولوية لكل بطاقة
2. ترتيب البطاقات تنازلياً حسب الأولوية
3. اختيار العدد المطلوب من الأعلى

### نظام النقاط
- **سهل**: interval × 2.5
- **متوسط**: interval × 1.5
- **صعب**: interval × 1.2

## أفضل الممارسات المطبقة

1. **Clean Architecture**: فصل طبقات البيانات والأعمال والواجهة
2. **MVVM Pattern**: فصل المنطق عن الواجهة
3. **Repository Pattern**: تجريد مصدر البيانات
4. **Reactive Programming**: استخدام Flow للبيانات التفاعلية
5. **Dependency Injection**: إدارة التبقيات بشكل مركزي
6. **Single Responsibility**: كل كلاس له مسؤولية واحدة
7. **Kotlin Coroutines**: معالجة غير متزامنة فعالة
8. **StateFlow**: إدارة الحالة بشكل reactive

## التطوير المستقبلي

- [ ] إشعارات التذكير بالمراجعة
- [ ] مزامنة السحابة (Cloud Sync)
- [ ] مشاركة المجموعات مع الآخرين
- [ ] إضافة صور للبطاقات
- [ ] دعم الصوت
- [ ] نظام نقاط وتحفيز
- [ ] إحصائيات متقدمة مع رسوم بيانية
- [ ] وضع عدم الاتصال بالكامل
- [ ] استيراد من CSV/Excel
- [ ] قوالب جاهزة للمجموعات

## المتطلبات

- Android 8.0 (API 26) فأعلى
- Kotlin 2.0.0
- Android Gradle Plugin 8.5.0
- Jetpack Compose

## الترخيص

هذا المشروع مجاني ومفتوح المصدر.

## المطور

تم تطوير هذا التطبيق كتطبيق تعليمي حديث يستخدم أحدث التقنيات.

---

**ملاحظة**: التطبيق يدعم اللغة العربية بالكامل مع اتجاه RTL وتصميم متجاوب يعمل على جميع أحجام الشاشات.
