
import 'package:flutter/cupertino.dart';

const Color bg = Color(0xFF090E1B);
const Color surface = Color(0xFF141D30);
const Color surface2 = Color(0xFF1C2840);
const Color purple = Color(0xFF9585FF);
const Color cyan = Color(0xFF4BE0CA);
const Color muted = Color(0xFF8995AD);
const Color white = Color(0xFFF5F6FC);

void main() {
  runApp(const StudyFlowApp());
}

class StudyTask {
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  bool isDone;

  StudyTask({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    this.isDone = false,
  });
}

class StudyFlowApp extends StatefulWidget {
  const StudyFlowApp({super.key});

  @override
  State<StudyFlowApp> createState() => _StudyFlowAppState();
}

class _StudyFlowAppState extends State<StudyFlowApp> {
  int selectedTab = 0;

  final List<StudyTask> tasks = [
    StudyTask(
      title: 'Review Physics',
      subtitle: 'Chapter 03 • 30 min',
      category: 'Physics',
      icon: CupertinoIcons.book_fill,
    ),
    StudyTask(
      title: 'Solve Math problems',
      subtitle: 'Exercise 2.1 • 45 min',
      category: 'Mathematics',
      icon: CupertinoIcons.pencil,
    ),
    StudyTask(
      title: 'English reading',
      subtitle: 'Unit 02 • 20 min',
      category: 'English',
      icon: CupertinoIcons.doc_text_fill,
    ),
    StudyTask(
      title: 'Revise Chemistry',
      subtitle: 'Chemical bonding • 25 min',
      category: 'Chemistry',
      icon: CupertinoIcons.book_fill,
    ),
  ];

  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: purple,
      ),
      home: CupertinoPageScaffold(
        backgroundColor: bg,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: selectedTab,
                  children: [
                    HomePage(
                      tasks: tasks,
                      onToggle: toggleTask,
                      onSeeAll: () {
                        setState(() => selectedTab = 1);
                      },
                    ),
                    TasksPage(
                      tasks: tasks,
                      onToggle: toggleTask,
                    ),
                    ProgressPage(tasks: tasks),
                    const ProfilePage(),
                  ],
                ),
              ),
              BottomNavigation(
                selectedIndex: selectedTab,
                onSelect: (index) {
                  setState(() => selectedTab = index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- HOME SCREEN ----------------

class HomePage extends StatelessWidget {
  final List<StudyTask> tasks;
  final Function(int) onToggle;
  final VoidCallback onSeeAll;

  const HomePage({
    super.key,
    required this.tasks,
    required this.onToggle,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final completed = tasks.where((task) => task.isDone).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'STUDYFLOW',
                      style: TextStyle(
                        color: purple,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 9),
                    Text(
                      'Good morning 👋',
                      style: TextStyle(
                        color: white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: surface2,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  CupertinoIcons.person_fill,
                  color: purple,
                  size: 23,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          const Text(
            'A fresh day to learn something new.',
            style: TextStyle(color: muted, fontSize: 14),
          ),
          const SizedBox(height: 25),

          // Weekly goal card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(21),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF6858D9),
                  Color(0xFF3D74B9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -30,
                  top: -40,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: white.withOpacity(0.07),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'YOUR WEEKLY GOAL',
                            style: TextStyle(
                              color: Color(0xFFDCD8FF),
                              fontSize: 10,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Stay focused.\nKeep growing.',
                            style: TextStyle(
                              color: white,
                              fontSize: 23,
                              height: 1.25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 13),
                          Text(
                            '$completed of ${tasks.length} tasks completed',
                            style: const TextStyle(
                              color: Color(0xFFE1DFFF),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: white.withOpacity(0.14),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: white.withOpacity(0.35),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        CupertinoIcons.bolt_fill,
                        color: white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),
          const SectionHeading(title: 'TODAY AT A GLANCE'),
          const SizedBox(height: 13),

          Row(
            children: [
              Expanded(
                child: StatCard(
                  icon: CupertinoIcons.check_mark_circled,
                  value: '$completed',
                  label: 'Completed',
                  color: cyan,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: StatCard(
                  icon: CupertinoIcons.clock,
                  value: '${tasks.length - completed}',
                  label: 'Remaining',
                  color: purple,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: StatCard(
                  icon: CupertinoIcons.book_fill,
                  value: '5',
                  label: 'Day streak',
                  color: Color(0xFFFFB86B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 27),
          const SectionHeading(title: 'FOCUS SESSION'),
          const SizedBox(height: 13),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(21),
              border: Border.all(color: surface2),
            ),
            child: Row(
              children: [
                Container(
                  width: 49,
                  height: 49,
                  decoration: BoxDecoration(
                    color: purple.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    CupertinoIcons.timer,
                    color: purple,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 13),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pomodoro focus',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '25 minutes of deep work',
                        style: TextStyle(color: muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '25:00',
                  style: TextStyle(
                    color: cyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 27),
          SectionHeading(
            title: 'TODAY\'S TASKS',
            action: 'See all',
            onAction: onSeeAll,
          ),
          const SizedBox(height: 12),

          ...List.generate(
            tasks.length < 3 ? tasks.length : 3,
                (index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TaskTile(
                task: tasks[index],
                onTap: () => onToggle(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- TASKS SCREEN ----------------

class TasksPage extends StatelessWidget {
  final List<StudyTask> tasks;
  final Function(int) onToggle;

  const TasksPage({
    super.key,
    required this.tasks,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final completed = tasks.where((task) => task.isDone).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(
            eyebrow: 'STAY ORGANIZED',
            title: 'My Tasks',
            subtitle: 'Small steps create big results.',
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(19),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Daily completion',
                      style: TextStyle(color: white, fontSize: 14),
                    ),
                    Text(
                      '$completed/${tasks.length}',
                      style: const TextStyle(
                        color: cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                ProgressBar(
                  value: tasks.isEmpty ? 0 : completed / tasks.length,
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),
          const SectionHeading(title: 'YOUR STUDY PLAN'),
          const SizedBox(height: 13),

          ...List.generate(
            tasks.length,
                (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TaskTile(
                task: tasks[index],
                onTap: () => onToggle(index),
              ),
            ),
          ),

          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: purple.withOpacity(0.10),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: purple.withOpacity(0.20)),
            ),
            child: const Row(
              children: [
                Icon(CupertinoIcons.lightbulb_fill, color: purple),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Tip: Focus on one task at a time. Consistency beats perfection.',
                    style: TextStyle(
                      color: Color(0xFFD0CBEF),
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- PROGRESS SCREEN ----------------

class ProgressPage extends StatelessWidget {
  final List<StudyTask> tasks;

  const ProgressPage({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completed = tasks.where((task) => task.isDone).length;
    final percentage =
    tasks.isEmpty ? 0 : (completed / tasks.length * 100).round();

    const values = [0.45, 0.75, 0.55, 0.9, 0.65, 0.35, 0.8];
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(
            eyebrow: 'YOUR JOURNEY',
            title: 'My Progress',
            subtitle: 'Look how far you have come.',
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF292354), Color(0xFF192E48)],
              ),
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TASK COMPLETION',
                  style: TextStyle(
                    color: muted,
                    letterSpacing: 1.4,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        color: white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 9, left: 8),
                      child: Text(
                        'of your daily tasks',
                        style: TextStyle(color: muted, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 17),
                ProgressBar(value: percentage / 100),
                const SizedBox(height: 13),
                Text(
                  '$completed tasks completed out of ${tasks.length}',
                  style: const TextStyle(color: muted, fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),
          const SectionHeading(title: 'WEEKLY ACTIVITY'),
          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(21),
              border: Border.all(color: surface2),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Study consistency',
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'This week',
                      style: TextStyle(color: muted, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                SizedBox(
                  height: 135,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(7, (index) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: values[index] * 100,
                              width: 17,
                              decoration: BoxDecoration(
                                color: index == 3 ? cyan : purple,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              days[index],
                              style: const TextStyle(
                                color: muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),
          const SectionHeading(title: 'YOUR ACHIEVEMENTS'),
          const SizedBox(height: 13),
          const AchievementTile(
            icon: CupertinoIcons.flame_fill,
            title: 'Consistency starter',
            subtitle: 'Build a five-day study streak',
            color: Color(0xFFFFB86B),
          ),
          const SizedBox(height: 10),
          const AchievementTile(
            icon: CupertinoIcons.bolt_fill,
            title: 'Focused learner',
            subtitle: 'Keep moving towards your goals',
            color: cyan,
          ),
        ],
      ),
    );
  }
}

// ---------------- PROFILE SCREEN ----------------

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(
            eyebrow: 'YOUR ACCOUNT',
            title: 'My Profile',
            subtitle: 'Manage your study space.',
          ),
          const SizedBox(height: 25),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(23),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(23),
              border: Border.all(color: surface2),
            ),
            child: Column(
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: purple.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.person_fill,
                    size: 36,
                    color: purple,
                  ),
                ),
                const SizedBox(height: 13),
                const Text(
                  'Student',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Your personal learning journey',
                  style: TextStyle(color: muted, fontSize: 12),
                ),
                const SizedBox(height: 17),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: purple.withOpacity(0.13),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'FREE PLAN',
                    style: TextStyle(
                      color: purple,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 27),
          const SectionHeading(title: 'PREFERENCES'),
          const SizedBox(height: 12),
          const SettingTile(
            icon: CupertinoIcons.bell_fill,
            title: 'Notifications',
            subtitle: 'Manage your reminders',
          ),
          const SizedBox(height: 10),
          const SettingTile(
            icon: CupertinoIcons.moon_fill,
            title: 'Appearance',
            subtitle: 'Dark theme',
          ),
          const SizedBox(height: 10),
          const SettingTile(
            icon: CupertinoIcons.lock_fill,
            title: 'Privacy & Security',
            subtitle: 'Your account protection',
          ),
          const SizedBox(height: 10),
          const SettingTile(
            icon: CupertinoIcons.question_circle_fill,
            title: 'Help & Support',
            subtitle: 'Get help with StudyFlow',
          ),
          const SizedBox(height: 25),
          const Center(
            child: Text(
              'STUDYFLOW • VERSION 1.0.0',
              style: TextStyle(
                color: muted,
                fontSize: 10,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

// ---------------- REUSABLE WIDGETS ----------------

class PageTitle extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;

  const PageTitle({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: const TextStyle(
            color: purple,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.6,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          title,
          style: const TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 29,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(color: muted, fontSize: 13),
        ),
      ],
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const SectionHeading({
    super.key,
    required this.title,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: muted,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.3,
            fontSize: 10,
          ),
        ),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              action!,
              style: const TextStyle(
                color: purple,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: surface2),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: muted, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final double value;

  const ProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 8,
        color: surface2,
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: value.clamp(0.0, 1.0).toDouble(),
            child: Container(color: cyan),
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final StudyTask task;
  final VoidCallback onTap;

  const TaskTile({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: surface2),
        ),
        child: Row(
          children: [
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                color: purple.withOpacity(0.12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(task.icon, color: purple, size: 21),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      color: task.isDone ? muted : white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    task.subtitle,
                    style: const TextStyle(color: muted, fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.isDone ? cyan : const Color(0x00141D30),
                border: Border.all(
                  color: task.isDone ? cyan : muted,
                  width: 1.5,
                ),
              ),
              child: task.isDone
                  ? const Icon(
                CupertinoIcons.check_mark,
                color: bg,
                size: 14,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class AchievementTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const AchievementTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: surface2),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 25),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(color: muted, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: surface2),
      ),
      child: Row(
        children: [
          Icon(icon, color: purple, size: 21),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: muted, fontSize: 10),
                ),
              ],
            ),
          ),
          const Icon(
            CupertinoIcons.chevron_right,
            color: muted,
            size: 15,
          ),
        ],
      ),
    );
  }
}

// ---------------- BOTTOM NAVIGATION ----------------

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  static const items = [
    (CupertinoIcons.house_fill, 'Home'),
    (CupertinoIcons.list_bullet, 'Tasks'),
    (CupertinoIcons.chart_bar_fill, 'Progress'),
    (CupertinoIcons.person_fill, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      decoration: BoxDecoration(
        color: surface,
        border: Border(
          top: BorderSide(color: surface2, width: 1),
        ),
      ),
      child: Row(
        children: List.generate(items.length, (index) {
          final selected = selectedIndex == index;
          final item = items[index];

          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onSelect(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.$1,
                    color: selected ? purple : muted,
                    size: 22,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.$2,
                    style: TextStyle(
                      color: selected ? purple : muted,
                      fontSize: 10,
                      fontWeight:
                      selected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
