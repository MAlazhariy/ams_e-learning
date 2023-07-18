class DummyData {
  static Map<String, dynamic> config = {
    'is_school_active': true,
    'school_name': 'مركز الجرايحي',
    'school_address': 'القاهرة، كذا كذا',
    'school_phone': '01013688985',
    'school_info': 'مركز الجرايحي هو أكبر وأفضل مركز في العالم',
    'base_urls': {
      "student_image_path": "https://wassalley.com/storage/app/public/profile",
      "question_image_path": "https://wassalley.com/storage/app/public/profile",
    },
    'android_config': {
      "status": false,
      "link": "",
      "min_version": 1,
    },
    'ios_config': {
      "status": false,
      "link": "",
      "min_version": 1,
    },
  };

  // Exam
  static List<Map<String, dynamic>> exams = [
    {
      "id": 15,
      "title": "اختبار على معادلات الحديد",
      "duration": 15,
      "can_review": false,
      "subject": {
        "id": 3,
        "title": "كيمياء عضوية",
      },
      "exam_category": {
        "id": 3,
        "title": "الكيمياء",
      },
    },
    {
      "id": 16,
      "title": "اختبار على معادلات الحديد",
      "duration": 15,
      "can_review": false,
      "subject": {
        "id": 3,
        "title": "كيمياء عضوية",
      },
      "exam_category": {
        "id": 3,
        "title": "الكيمياء",
      },
    },
    {
      "id": 17,
      "title": "اختبار على معادلات الحديد",
      "duration": 15,
      "can_review": false,
      "subject": {
        "id": 3,
        "title": "كيمياء عضوية",
      },
      "exam_category": {
        "id": 3,
        "title": "الكيمياء",
      },
    },
  ];

  static Map<String, dynamic> examDetails = {
    "id": 15,
    "title": "اختبار على معادلات الحديد",
    "duration": 1,
    "can_review": false,
    "is_done": false,
    "subject": {
      "id": 3,
      "title": "كيمياء عضوية",
    },
    "exam_category": {
      "id": 3,
      "title": "الكيمياء",
    },
    "questions": [
      {
        "title": "ما ناتج هذه المسألة؟",
        "id": 12,
        "degree": 1,
        "multiple_choice": false,
        "image": "https://abunawaf.com/wp-content/uploads/2016/06/elementary-math-problems.jpg",
        "answers": [
          {
            "title": "6",
            "is_correct": false,
          },
          {
            "title": "1",
            "is_correct": true,
          },
          {
            "title": "3",
            "is_correct": false,
          },
          {
            "title": "0",
            "is_correct": false,
          },
        ],
      },
      {
        "title": "اختيار من متعدد ..",
        "multiple_choice": true,
        "image": null,
        "id": 12,
        "degree": 2,
        "answers": [
          {
            "title": "اختيار 1",
            "is_correct": true,
          },
          {
            "title": "اختيار 2",
            "is_correct": true,
          },
          {
            "title": "اختيار 3",
            "is_correct": false,
          },
          {
            "title": "اختيار 4",
            "is_correct": true,
          },
        ],
      },
      {
        "title": "4 + 5 = ?", // todo: handle from question to title
        "multiple_choice": false,
        "image": null,
        "id": 12,
        "degree": 1,
        "answers": [
          {
            "title": "20",
            "is_correct": false,
          },
          {
            "title": "45",
            "is_correct": false,
          },
          {
            "title": "9",
            "is_correct": true,
          },
          {
            "title": "15",
            "is_correct": false,
          },
        ],
      },
      {
        "title": "4 + 10 = ?",
        "multiple_choice": false,
        "image": null,
        "id": 12,
        "degree": 2,
        "answers": [
          {
            "title": "410",
            "is_correct": false,
          },
          {
            "title": "14",
            "is_correct": true,
          },
          {
            "title": "401",
            "is_correct": false,
          },
          {
            "title": "41",
            "is_correct": false,
          },
        ],
      },
      {
        "title": "5 X 7 = ?",
        "multiple_choice": false,
        "image": null,
        "id": 12,
        "degree": 1,
        "answers": [
          {
            "title": "12",
            "is_correct": false,
          },
          {
            "title": "57",
            "is_correct": false,
          },
          {
            "title": "37",
            "is_correct": false,
          },
          {
            "title": "35",
            "is_correct": true,
          },
        ],
      },
    ],
  };

  // Lesson
  static List<Map<String, dynamic>> lessons = [
    {
      "id": 5,
      "title": "الباب الثالث - الصف الثاني الثانوي",
      "short_description":
          "إخواتي طلاب الصف الثاني الثانوي ...\nمنستكمش و عملتلكم مراجعة على الوحدة الثالثة كاملة ✌️\nالعمل ده خالص لوجه الله لإفادة جميع الطلاب تقبلوا تحياتي",
      "thumbnail": "https://www.elmin7a.com/wp-content/uploads/2020/04/chemistry.jpg",
      "subject": {
        "id": 3,
        "title": "كيمياء",
      },
      "teacher": {
        "id": 5,
        "name": "د. أحمد الجرايحي",
        "image": "https://yt3.ggpht.com/ytc/AMLnZu8mLIB1shbQE04xeroRye0sKHreCOFQH_mbdZSZ=s88-c-k-c0x00ffffff-no-rj"
      },
      "total_duration": "16:46",
    },
    {
      "id": 5,
      "title": "قانون هس - النظام الجديد",
      "short_description": "قانون هس - النظام الجديد الصف الأول الثانوي",
      "thumbnail": "https://i.ytimg.com/vi/XGnLVNiXr_c/maxresdefault.jpg",
      "subject": {
        "id": 3,
        "title": "كيمياء",
      },
      "teacher": {
        "id": 5,
        "name": "د. أحمد الجرايحي",
        "image": "https://yt3.ggpht.com/ytc/AMLnZu8mLIB1shbQE04xeroRye0sKHreCOFQH_mbdZSZ=s88-c-k-c0x00ffffff-no-rj"
      },
      "total_duration": "07:24",
    },
    {
      "id": 5,
      "title": "قانون فترة نصف العمر-الصف الأول الثانوي -نظام جديد",
      "short_description":
          "إخواتي طلاب الصف الثاني الثانوي ...\nمنستكمش و عملتلكم مراجعة على الوحدة الثالثة كاملة ✌️\nالعمل ده خالص لوجه الله لإفادة جميع الطلاب تقبلوا تحياتي",
      "thumbnail":
          "https://i.ytimg.com/vi/PG-3f0ugmV8/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB4XXK3nnQantrw95x_T70JJmXi8w",
      "subject": {
        "id": 3,
        "title": "كيمياء",
      },
      "teacher": {
        "id": 5,
        "name": "د. أحمد الجرايحي",
        "image": "https://yt3.ggpht.com/ytc/AMLnZu8mLIB1shbQE04xeroRye0sKHreCOFQH_mbdZSZ=s88-c-k-c0x00ffffff-no-rj"
      },
      "total_duration": "16:46",
    },
    {
      "id": 5,
      "title": "مراجعة الصف الأول الثانوي 2022 - الترم الأول",
      "short_description":
          "إخواتي طلاب الصف الثاني الثانوي ...\nمنستكمش و عملتلكم مراجعة على الوحدة الثالثة كاملة ✌️\nالعمل ده خالص لوجه الله لإفادة جميع الطلاب تقبلوا تحياتي",
      "thumbnail":
          "https://i.ytimg.com/vi/3ucJlKDwsi4/hqdefault.jpg?sqp=-oaymwE1CKgBEF5IVfKriqkDKAgBFQAAiEIYAXABwAEG8AEB-AH8CYAC0AWKAgwIABABGH8gOygTMA8=&rs=AOn4CLB8FaQ8VZB3cNR8rg84gQeEBFoSCQ",
      "subject": {
        "id": 3,
        "title": "كيمياء",
      },
      "teacher": {
        "id": 5,
        "name": "د. أحمد الجرايحي",
        "image": "https://yt3.ggpht.com/ytc/AMLnZu8mLIB1shbQE04xeroRye0sKHreCOFQH_mbdZSZ=s88-c-k-c0x00ffffff-no-rj"
      },
      "total_duration": "16:46",
    },
    {
      "id": 5,
      "title": "مقدمة سريعة للجدول الدوري الحديث-باب الحديد للصف الثالث الثانوي",
      "short_description":
          "إخواتي طلاب الصف الثاني الثانوي ...\nمنستكمش و عملتلكم مراجعة على الوحدة الثالثة كاملة ✌️\nالعمل ده خالص لوجه الله لإفادة جميع الطلاب تقبلوا تحياتي",
      "thumbnail":
          "https://i.ytimg.com/vi/dAHU4RD5eBY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB-WtCAv3q9lF7q9_q-Ki1rLEYXeg",
      "subject": {
        "id": 3,
        "title": "كيمياء",
      },
      "teacher": {
        "id": 5,
        "name": "د. أحمد الجرايحي",
        "image": "https://yt3.ggpht.com/ytc/AMLnZu8mLIB1shbQE04xeroRye0sKHreCOFQH_mbdZSZ=s88-c-k-c0x00ffffff-no-rj"
      },
      "total_duration": "16:46",
    },
    {
      "id": 5,
      "title": "الباب الثالث - الصف الثاني الثانوي",
      "short_description":
          "إخواتي طلاب الصف الثاني الثانوي ...\nمنستكمش و عملتلكم مراجعة على الوحدة الثالثة كاملة ✌️\nالعمل ده خالص لوجه الله لإفادة جميع الطلاب تقبلوا تحياتي",
      "thumbnail": "https://www.elmin7a.com/wp-content/uploads/2020/04/chemistry.jpg",
      "subject": {
        "id": 3,
        "title": "كيمياء",
      },
      "teacher": {
        "id": 5,
        "name": "د. أحمد الجرايحي",
        "image": "https://yt3.ggpht.com/ytc/AMLnZu8mLIB1shbQE04xeroRye0sKHreCOFQH_mbdZSZ=s88-c-k-c0x00ffffff-no-rj"
      },
      "total_duration": "16:46",
    },
    {
      "id": 5,
      "title": "قانون هس - النظام الجديد",
      "short_description": "قانون هس - النظام الجديد الصف الأول الثانوي",
      "thumbnail": "https://i.ytimg.com/vi/XGnLVNiXr_c/maxresdefault.jpg",
      "subject": {
        "id": 3,
        "title": "كيمياء",
      },
      "teacher": {
        "id": 5,
        "name": "د. أحمد الجرايحي",
        "image": "https://yt3.ggpht.com/ytc/AMLnZu8mLIB1shbQE04xeroRye0sKHreCOFQH_mbdZSZ=s88-c-k-c0x00ffffff-no-rj"
      },
      "total_duration": "07:24",
    },
    {
      "id": 5,
      "title": "قانون فترة نصف العمر-الصف الأول الثانوي -نظام جديد",
      "short_description":
          "إخواتي طلاب الصف الثاني الثانوي ...\nمنستكمش و عملتلكم مراجعة على الوحدة الثالثة كاملة ✌️\nالعمل ده خالص لوجه الله لإفادة جميع الطلاب تقبلوا تحياتي",
      "thumbnail":
          "https://i.ytimg.com/vi/PG-3f0ugmV8/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB4XXK3nnQantrw95x_T70JJmXi8w",
      "subject": {
        "id": 3,
        "title": "كيمياء",
      },
      "teacher": {
        "id": 5,
        "name": "د. أحمد الجرايحي",
        "image": "https://yt3.ggpht.com/ytc/AMLnZu8mLIB1shbQE04xeroRye0sKHreCOFQH_mbdZSZ=s88-c-k-c0x00ffffff-no-rj"
      },
      "total_duration": "16:46",
    },
    {
      "id": 5,
      "title": "مراجعة الصف الأول الثانوي 2022 - الترم الأول",
      "short_description":
          "إخواتي طلاب الصف الثاني الثانوي ...\nمنستكمش و عملتلكم مراجعة على الوحدة الثالثة كاملة ✌️\nالعمل ده خالص لوجه الله لإفادة جميع الطلاب تقبلوا تحياتي",
      "thumbnail":
          "https://i.ytimg.com/vi/3ucJlKDwsi4/hqdefault.jpg?sqp=-oaymwE1CKgBEF5IVfKriqkDKAgBFQAAiEIYAXABwAEG8AEB-AH8CYAC0AWKAgwIABABGH8gOygTMA8=&rs=AOn4CLB8FaQ8VZB3cNR8rg84gQeEBFoSCQ",
      "subject": {
        "id": 3,
        "title": "كيمياء",
      },
      "teacher": {
        "id": 5,
        "name": "د. أحمد الجرايحي",
        "image": "https://yt3.ggpht.com/ytc/AMLnZu8mLIB1shbQE04xeroRye0sKHreCOFQH_mbdZSZ=s88-c-k-c0x00ffffff-no-rj"
      },
      "total_duration": "16:46",
    },
    {
      "id": 5,
      "title": "مقدمة سريعة للجدول الدوري الحديث-باب الحديد للصف الثالث الثانوي",
      "short_description":
          "إخواتي طلاب الصف الثاني الثانوي ...\nمنستكمش و عملتلكم مراجعة على الوحدة الثالثة كاملة ✌️\nالعمل ده خالص لوجه الله لإفادة جميع الطلاب تقبلوا تحياتي",
      "thumbnail":
          "https://i.ytimg.com/vi/dAHU4RD5eBY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB-WtCAv3q9lF7q9_q-Ki1rLEYXeg",
      "subject": {
        "id": 3,
        "title": "كيمياء",
      },
      "teacher": {
        "id": 5,
        "name": "د. أحمد الجرايحي",
        "image": "https://yt3.ggpht.com/ytc/AMLnZu8mLIB1shbQE04xeroRye0sKHreCOFQH_mbdZSZ=s88-c-k-c0x00ffffff-no-rj"
      },
      "total_duration": "16:46",
    },
  ];

  static Map<String, dynamic> lessonDetails = {
    "status": true,
    "message": "lesson retrieved successfully",
    "data": {
      "id": 5,
      "title": "الباب الثالث- الصف الثاني الثانوي",
      "short_description":
          "إخواتي طلاب الصف الثاني الثانوي ...\nمنستكمش و عملتلكم مراجعة على الوحدة الثالثة كاملة ✌️\nالعمل ده خالص لوجه الله لإفادة جميع الطلاب تقبلوا تحياتي",
      "thumbnail": "https://www.elmin7a.com/wp-content/uploads/2020/04/chemistry.jpg",
      "subject": {
        "id": 3,
        "title": "كيمياء",
      },
      "teacher": {
        "id": 5,
        "name": "د. أحمد الجرايحي",
        "image": "https://yt3.ggpht.com/ytc/AMLnZu8mLIB1shbQE04xeroRye0sKHreCOFQH_mbdZSZ=s88-c-k-c0x00ffffff-no-rj"
      },
      "total_duration": "00:16:46", // String
      "lessons": [
        {
          "title": "المعادلة الكيميائية و نظرية الثمانيات و تنافر أزواج الإليكترونات الحرة و علاقتها بقيم الزوايا",
          "id": 12,
          "type": "video",
          "duration": "37:35",
          "parent": 15,
          "video_type": "YouTube",
          "video_url": "https://youtu.be/kWCz3EgMZ7A",
          "is_completed": false,
        },
        {
          "title": "الروابط الكيميائية و الفيزيائية",
          "id": 13,
          "type": "video",
          "duration": "37:35",
          "parent": 15,
          "video_type": "YouTube",
          "video_url": "https://youtu.be/cUBXCaaWGJQ",
          "is_completed": false,
        },
        {
          "title": "التهجين و تداخل الأوربيتالات",
          "id": 14,
          "type": "video",
          "duration": "37:35",
          "parent": 15,
          "video_type": "YouTube",
          "video_url": "https://youtu.be/OXahy4hqx9o",
          "is_completed": false,
        },
      ],
    },
  };

  static Map<String, dynamic> subjects = {
    "status": true,
    "message": "subjects retrieved successfully",
    "data": [
      {
        "id": 1,
        "name": "علوم",
        "class_id": "1",
        "school_id": "1",
        "session_id": "1",
        "created_at": "2022-11-24T00:49:48.000000Z",
        "updated_at": "2022-11-24T00:49:48.000000Z"
      },
      {
        "id": 2,
        "name": "احياء",
        "class_id": "1",
        "school_id": "1",
        "session_id": "1",
        "created_at": "2022-11-24T00:49:59.000000Z",
        "updated_at": "2022-11-24T00:49:59.000000Z"
      },
      {
        "id": 3,
        "name": "فيزياء",
        "class_id": "1",
        "school_id": "1",
        "session_id": "1",
        "created_at": "2022-11-24T00:50:13.000000Z",
        "updated_at": "2022-11-24T00:50:13.000000Z"
      },
      {
        "id": 4,
        "name": "كيمياء",
        "class_id": "1",
        "school_id": "1",
        "session_id": "1",
        "created_at": "2022-12-06T15:39:39.000000Z",
        "updated_at": "2022-12-06T15:39:39.000000Z"
      }
    ]
  };

  static Map<String, dynamic> subjects2 = {
    "status": true,
    "message": "subjects retrieved successfully",
    "data": [
      {
        "id": 1,
        "name": "علوم",
        "class_id": "1",
        "school_id": "1",
        "session_id": "1",
        "created_at": "2022-11-24T00:49:48.000000Z",
        "updated_at": "2022-11-24T00:49:48.000000Z"
      },
    ]
  };
}
