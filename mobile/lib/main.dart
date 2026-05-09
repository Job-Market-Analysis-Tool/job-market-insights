import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const AdminConsoleApp());
}

// ─── Theme Colors ────────────────────────────────────────────────────────────
const Color kBackground  = Color(0xFF0A0E1A);
const Color kCard        = Color(0xFF111827);
const Color kCyan        = Color(0xFF00D4FF);
const Color kGreen       = Color(0xFF00FF88);
const Color kRed         = Color(0xFFFF4444);
const Color kOrange      = Color(0xFFFF8C00);
const Color kBorder      = Color(0xFF1F2937);
const Color kMuted       = Color(0xFF94A3B8);

// ─── App Root ────────────────────────────────────────────────────────────────
class AdminConsoleApp extends StatelessWidget {
  const AdminConsoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Console',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackground,
        fontFamily: 'sans-serif',
        colorScheme: ColorScheme.dark(
          primary: kCyan,
          surface: kCard,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SCREEN 1 — Admin Login
// ═══════════════════════════════════════════════════════════════════════════════
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading     = false;
  bool _obscure     = true;
  String? _error;

  void _login() async {
    final email    = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'Please enter email and password.');
      return;
    }

    setState(() { _loading = true; _error = null; });
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _loading = false);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Row(
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: kCyan.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.security, color: kCyan, size: 22),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Admin Console',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Text('Virtual Job Market Tool',
                          style: TextStyle(color: kCyan, fontSize: 11)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // Title
              const Text('Welcome Back',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Sign in to access the admin dashboard',
                  style: TextStyle(color: kMuted, fontSize: 13)),

              const SizedBox(height: 40),

              // Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: kCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: kBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email
                    const Text('Email Address',
                        style: TextStyle(
                            color: kMuted,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration(
                        hint: 'admin@jobmarket.com',
                        icon: Icons.email_outlined,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Password
                    const Text('Password',
                        style: TextStyle(
                            color: kMuted,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscure,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration(
                        hint: '••••••••',
                        icon: Icons.lock_outline,
                      ).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure ? Icons.visibility_off : Icons.visibility,
                            color: kMuted, size: 18,
                          ),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                    ),

                    if (_error != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: kRed.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: kRed.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: kRed, size: 16),
                            const SizedBox(width: 8),
                            Text(_error!,
                                style: const TextStyle(color: kRed, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kCyan,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _loading
                            ? const SizedBox(
                                width: 20, height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.black,
                                ),
                              )
                            : const Text('Sign In',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Hint
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: kCyan.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: kCyan.withOpacity(0.2)),
                  ),
                  child: const Text(
                    'Demo: any email + password',
                    style: TextStyle(color: kCyan, fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) =>
      InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: kMuted, fontSize: 13),
        prefixIcon: Icon(icon, color: kMuted, size: 18),
        filled: true,
        fillColor: kBackground,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kCyan, width: 1.5),
        ),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SCREEN 2 — Health Dashboard
// ═══════════════════════════════════════════════════════════════════════════════
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  late Timer _timer;
  int _cpu    = 42;
  int _ram    = 48;
  int _load   = 45;
  String _lastUpdated = 'just now';
  int _secondsAgo = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      final rng = Random();
      setState(() {
        _cpu  = 35 + rng.nextInt(25);
        _ram  = 40 + rng.nextInt(20);
        _load = 38 + rng.nextInt(22);
        _secondsAgo += 5;
        _lastUpdated = _secondsAgo < 60
            ? '${_secondsAgo}s ago'
            : '${(_secondsAgo / 60).floor()}m ago';
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.security, color: kCyan, size: 20),
            SizedBox(width: 8),
            Text('Admin Console',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          // Live badge
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: kGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kGreen.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 6, height: 6,
                  decoration: const BoxDecoration(
                    color: kGreen, shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                const Text('LIVE',
                    style: TextStyle(
                        color: kGreen, fontSize: 10,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Logout
          IconButton(
            icon: const Icon(Icons.logout, color: kMuted, size: 20),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildDashboardTab(),
          const AlertsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0D1117),
          border: Border(top: BorderSide(color: kBorder)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          backgroundColor: Colors.transparent,
          selectedItemColor: kCyan,
          unselectedItemColor: kMuted,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              activeIcon: Icon(Icons.notifications),
              label: 'Alerts',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('System Health',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text('Real-time server monitoring',
                      style: TextStyle(color: kMuted, fontSize: 12)),
                ],
              ),
              Text('Updated $_lastUpdated',
                  style: const TextStyle(color: kMuted, fontSize: 11)),
            ],
          ),

          const SizedBox(height: 16),

          // Security Status Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kGreen.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kGreen.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kGreen.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.shield_outlined,
                      color: kGreen, size: 20),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('System Security: SECURE',
                        style: TextStyle(
                            color: kGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            letterSpacing: 0.5)),
                    Text('All systems operational — No threats detected',
                        style: TextStyle(color: kMuted, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Overall Health Card
          _buildInfoCard(
            icon: Icons.computer,
            iconColor: kCyan,
            title: 'Overall Server Health',
            value: 'OK',
            valueColor: kGreen,
            subtitle: 'prod-us-east-1 · Uptime 99.8%',
          ),

          const SizedBox(height: 12),

          // Metric Gauges Row
          Row(
            children: [
              Expanded(child: _buildGaugeCard('CPU Usage', _cpu, kCyan)),
              const SizedBox(width: 12),
              Expanded(child: _buildGaugeCard('RAM Usage', _ram, kOrange)),
            ],
          ),

          const SizedBox(height: 12),

          // Load Card
          _buildInfoCard(
            icon: Icons.speed,
            iconColor: kOrange,
            title: 'Current Load',
            value: '$_load%',
            valueColor: _load > 70 ? kRed : _load > 50 ? kOrange : kGreen,
            subtitle: 'Averaged over last 5 minutes',
          ),

          const SizedBox(height: 12),

          // Stats Row
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Active Sessions',
                  '${200 + Random().nextInt(80)}',
                  Icons.people_outline,
                  kCyan,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'API Requests',
                  '${1200 + Random().nextInt(300)}/hr',
                  Icons.api,
                  kGreen,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Module Status
          _buildSectionHeader('Module Status'),
          const SizedBox(height: 8),
          ...[
            ('Module 2 — LinkedIn Scraper', false, 'Error 503'),
            ('Module 3 — NLP Parser',       true,  'Running'),
            ('Module 5 — Skill Analyzer',   true,  'Running'),
            ('Module 8 — Admin Console',    true,  'Running'),
          ].map((m) => _buildModuleRow(m.$1, m.$2, m.$3)),
        ],
      ),
    );
  }

  Widget _buildGaugeCard(String label, int percent, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(
                  color: kMuted, fontSize: 11,
                  fontWeight: FontWeight.w600, letterSpacing: 0.5)),
          const SizedBox(height: 16),
          SizedBox(
            width: 80, height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: percent / 100,
                  strokeWidth: 7,
                  backgroundColor: kBorder,
                  color: color,
                ),
                Text('$percent%',
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: (percent > 80 ? kRed : color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              percent > 80 ? 'HIGH' : percent > 60 ? 'MODERATE' : 'NORMAL',
              style: TextStyle(
                  color: percent > 80 ? kRed : color,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required Color valueColor,
    required String subtitle,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kBorder),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(color: kMuted, fontSize: 12)),
                  Text(value,
                      style: TextStyle(
                          color: valueColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text(subtitle,
                      style: const TextStyle(color: kMuted, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) =>
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(height: 8),
            Text(value,
                style: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text(label,
                style: const TextStyle(color: kMuted, fontSize: 11)),
          ],
        ),
      );

  Widget _buildSectionHeader(String title) => Text(
        title,
        style: const TextStyle(
            color: kCyan,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8),
      );

  Widget _buildModuleRow(String name, bool ok, String status) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: ok ? kBorder : kRed.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(
              ok ? Icons.check_circle : Icons.error,
              color: ok ? kGreen : kRed,
              size: 16,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(name,
                  style: const TextStyle(color: Colors.white, fontSize: 13)),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: (ok ? kGreen : kRed).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(status,
                  style: TextStyle(
                      color: ok ? kGreen : kRed,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SCREEN 3 — Alerts List
// ═══════════════════════════════════════════════════════════════════════════════
class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final List<Map<String, dynamic>> _alerts = [
    {
      'id': 1,
      'severity': 'critical',
      'title': 'LinkedIn Scraper Failed',
      'module': 'Module 2',
      'errorCode': '503',
      'timestamp': '2 min ago',
      'description': 'Service unavailable — LinkedIn blocked the scraping request.',
      'resolved': false,
    },
    {
      'id': 2,
      'severity': 'warning',
      'title': 'NLP Parser Performance Degraded',
      'module': 'Module 3',
      'errorCode': 'PERF',
      'timestamp': '15 min ago',
      'description': 'Response time exceeded 800ms threshold. Processing queue building up.',
      'resolved': false,
    },
    {
      'id': 3,
      'severity': 'info',
      'title': 'MongoDB Atlas Connection Pool Low',
      'module': 'Database',
      'errorCode': 'POOL',
      'timestamp': '1 hr ago',
      'description': 'Connection pool usage at 85%. Consider scaling up.',
      'resolved': false,
    },
    {
      'id': 4,
      'severity': 'critical',
      'title': 'API Rate Limit Reached',
      'module': 'Module 5',
      'errorCode': '429',
      'timestamp': '3 hr ago',
      'description': 'OpenAI API rate limit hit. Requests queued for retry.',
      'resolved': true,
    },
  ];

  void _resolveAlert(int id) {
    setState(() {
      final idx = _alerts.indexWhere((a) => a['id'] == id);
      if (idx != -1) _alerts[idx]['resolved'] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Alert marked as resolved'),
        backgroundColor: kGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _restartScraper() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 16, height: 16,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Text('Restarting scraper service...'),
          ],
        ),
        backgroundColor: kCyan.withOpacity(0.8),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      final idx = _alerts.indexWhere((a) => a['errorCode'] == '503');
      if (idx != -1) _alerts[idx]['resolved'] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('✓ Scraper restarted successfully'),
        backgroundColor: kGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final active   = _alerts.where((a) => !a['resolved']).toList();
    final resolved = _alerts.where((a) => a['resolved']).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('System Alerts',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text('Monitor and resolve issues',
                      style: TextStyle(color: kMuted, fontSize: 12)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: active.isNotEmpty
                      ? kRed.withOpacity(0.1)
                      : kGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: active.isNotEmpty
                        ? kRed.withOpacity(0.3)
                        : kGreen.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  active.isNotEmpty
                      ? '${active.length} ACTIVE'
                      : 'ALL CLEAR',
                  style: TextStyle(
                      color: active.isNotEmpty ? kRed : kGreen,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Quick Action
          if (active.any((a) => a['errorCode'] == '503'))
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: kRed.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kRed.withOpacity(0.25)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber, color: kRed, size: 18),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text('LinkedIn Scraper needs restart',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  GestureDetector(
                    onTap: _restartScraper,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: kCyan,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Restart',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11)),
                    ),
                  ),
                ],
              ),
            ),

          // Active Alerts
          if (active.isNotEmpty) ...[
            const Text('● ACTIVE ALERTS',
                style: TextStyle(
                    color: kCyan,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1)),
            const SizedBox(height: 8),
            ...active.map((a) => _buildAlertCard(a)),
            const SizedBox(height: 16),
          ],

          // Resolved Alerts
          if (resolved.isNotEmpty) ...[
            const Text('● RESOLVED',
                style: TextStyle(
                    color: kMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1)),
            const SizedBox(height: 8),
            ...resolved.map((a) => _buildAlertCard(a)),
          ],
        ],
      ),
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    final isResolved = alert['resolved'] as bool;
    final severity   = alert['severity'] as String;

    Color borderColor;
    Color iconColor;
    IconData icon;

    if (isResolved) {
      borderColor = kBorder;
      iconColor   = kGreen;
      icon        = Icons.check_circle;
    } else {
      switch (severity) {
        case 'critical':
          borderColor = kRed.withOpacity(0.4);
          iconColor   = kRed;
          icon        = Icons.error;
          break;
        case 'warning':
          borderColor = kOrange.withOpacity(0.4);
          iconColor   = kOrange;
          icon        = Icons.warning_amber;
          break;
        default:
          borderColor = kCyan.withOpacity(0.3);
          iconColor   = kCyan;
          icon        = Icons.info_outline;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: iconColor, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(alert['title'],
                          style: TextStyle(
                              color: isResolved
                                  ? kMuted
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      const SizedBox(height: 3),
                      Text(alert['description'],
                          style: const TextStyle(
                              color: kMuted, fontSize: 11)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _pill(alert['module'], kCyan),
                          const SizedBox(width: 6),
                          _pill('Error: ${alert['errorCode']}',
                              isResolved ? kMuted : iconColor),
                          const SizedBox(width: 6),
                          _pill(alert['timestamp'], kMuted),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isResolved)
            InkWell(
              onTap: () => _resolveAlert(alert['id']),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: kGreen.withOpacity(0.06),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  border: Border(
                    top: BorderSide(color: kGreen.withOpacity(0.2)),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, color: kGreen, size: 14),
                    SizedBox(width: 6),
                    Text('Mark as Resolved',
                        style: TextStyle(
                            color: kGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _pill(String label, Color color) => Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: TextStyle(color: color, fontSize: 9,
                fontWeight: FontWeight.w600)),
      );
}
