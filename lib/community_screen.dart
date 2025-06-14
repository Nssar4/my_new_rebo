// community_screen.dart
import 'package:flutter/material.dart';
import 'community2_screen.dart'; // تأكد من المسار الصحيح

/// ————————————————————————————
///  قيم ثابتة قابلة للتعديل بسهولة ↓
/// ————————————————————————————
const Color kScreenBackgroundColor = Colors.white;
const Color kMetricTextColor = Color(0xFF001F3F);
const double kCardDividerThickness = 1.0;
const double kMetricsDividerThickness = 2.0;
const double kInvestBtnWidth = 114.0;
const double kInvestBtnHeight = 32.0;
const Color kInvestBtnColor = Color(0xFF001F3F);
const Color kInvestBtnTextColor = Colors.white;

const Color kSearchBarFillColor = Color(0xFFF5F5F5);
const Color kSearchBarHintTextColor = Color(0xFF7E9ACF);
const Color kSearchBarIconColor = Color(0xFF7E9ACF);

/// ————————————————————————————
///  نهاية القيم القابلة للتعديل
/// ————————————————————————————

/// ————————————————————————————
///  الصفحة الأولى: CommunityScreen
/// ————————————————————————————
class CommunityScreen extends StatefulWidget {
  // تحويلها لـ StatefulWidget لإضافة البحث
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<InvestmentCardB> items = [];

  final List<Map<String, String>> investorPosts = [
    {
      'avatar': 'assets/Ahmed.png',
      'name': 'Ahmed Ali',
      'subtitle': 'invested in FAKHR / Seemly',
      'content':
          'Investing here is the best decision to help children in school and shift perceptions of healthy food. It’ll be a global company soon.',
    },
    {
      'avatar': 'assets/Rana.png',
      'name': 'Rana Atef',
      'subtitle': 'invested in Mother Naked / Beyond',
      'content':
          'Great vision here—clean beauty for everyone. I believe this is the next big thing in wellness.',
    },
    {
      'avatar': 'assets/omar.png',
      'name': 'Omar Saad',
      'subtitle': 'invested in Infuse / eros',
      'content':
          'I see strong growth potential, especially with the team’s track record. Excited to be on board!',
    },
  ];

  final List<Map<String, String>> discussionReplies = [
    {
      'avatar': 'assets/Rahma.png',
      'name': 'Rahma Radi',
      'subtitle': 'invested in FAKHR / Zero Sugar By Ketonista',
      'content':
          'I think the Fintech sector is the best, especially with the rise of electronic payments in Egypt.',
    },
    {
      'avatar': 'assets/Othman.png',
      'name': 'Othman Qadi',
      'subtitle': 'invested in FAKHR / Seemly',
      'content': 'Fast-food is profitable, but competition is intense.',
    },
    {
      'avatar': 'assets/Dr.png',
      'name': 'Dr. Norhan Salah',
      'subtitle': 'Founder of Zero Sugar By Ketonista',
      'content':
          'We offer a new healthy fast-food experience. Do you think this is a good investment?',
    },
    {
      'avatar': 'assets/omar.png',
      'name': 'Omar Saad',
      'subtitle': 'invested in Infuse / eros',
      'content':
          'Replied on Dr. Norhan: With a clear expansion plan and strong sales, the market definitely needs this!',
    },
  ];

  final List<Map<String, String>> opportunityMetrics = [
    {'label': 'Funding Goal', 'value': '500,000 L.E - 850,000 L.E'},
    {'label': 'Completed Funding', 'value': '330,000 L.E'},
    {'label': 'Expected Success Rate', 'value': '93%'},
    {'label': 'Investment State', 'value': 'Long term'},
    {'label': 'Minimum investment', 'value': '7,000 L.E'},
    {'label': 'Maximum investment', 'value': '14,000 L.E'},
    {'label': 'Deadline', 'value': '16 Oct, 2025'},
    {'label': 'Location', 'value': 'Warehouse'},
    {'label': 'Strength', 'value': 'Strong technical team'},
    {'label': 'Challenges', 'value': 'Attract customers.'},
  ];

  String _searchQuery = ''; // لمدخل البحث
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF003366);
    const accentRed = Color(0xFFE53935);
    const dividerColor = Color(0xFFDDDDDD);

    final filteredItems = items
        .where((item) =>
            item.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: kScreenBackgroundColor,
      appBar: AppBar(
        backgroundColor: kScreenBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false, // إزالة سهم الرجوع
        titleSpacing: 16,
        title: Row(children: [
          Image.asset('assets/logo.png', width: 70, height: 70),
          const SizedBox(width: 8),
          const Text('INVESTA',
              style: TextStyle(
                  color: primaryBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ]),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active, color: primaryBlue),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // --- Trending Brands + Search
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text('Trending Brands',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search Trending Brands',
                hintStyle:
                    TextStyle(color: kSearchBarHintTextColor, fontSize: 14),
                filled: true,
                fillColor: kSearchBarFillColor,
                prefixIcon: Icon(Icons.search, color: kSearchBarIconColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // --- 4 Cards (Filtered by search)
          ListView.builder(
            itemCount: filteredItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (c, i) {
              final it = filteredItems[i];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InvestmentCardB(
                  assetImage: it.assetImage,
                  title: it.title,
                  description: it.description,
                  investedAmount: it.investedAmount,
                  investors: it.investors,
                  onTap: () {
                    // الانتقال إلى Community2Screen فقط إذا كان العنصر "FAKHR"
                    if (it.title == 'FAKHR') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const Community2Screen()),
                      );
                    }
                  },
                  onBookmarkPressed: () {
                    // هنا يمكن إضافة منطق الحفظ لـ CommunityScreen
                    // أو يمكنك استخدام نفس دالة _toggleBookmark إذا كان لديك قائمة savedItems هنا
                  },
                  isSaved: false, // تحتاج إلى ربط هذا بحالة الحفظ الفعلية
                ),
              );
            },
          ),

          // --- Investors Posts (باقي الأقسام تظل كما هي حالياً)
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
            child: Text('Investors Posts',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue)),
          ),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: investorPosts.length,
            separatorBuilder: (_, __) => const Divider(
                color: dividerColor, thickness: kCardDividerThickness),
            itemBuilder: (c, i) {
              final p = investorPosts[i];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        CircleAvatar(
                            radius: 28,
                            backgroundImage: AssetImage(p['avatar']!)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p['name']!,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: primaryBlue)),
                                const SizedBox(height: 4),
                                Text(p['subtitle']!,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryBlue)),
                              ]),
                        ),
                      ]),
                      const SizedBox(height: 8),
                      Text(p['content']!),
                    ]),
              );
            },
          ),

          // --- Latest Discussions
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
            child: Text('Latest Discussions',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('What is the best sectors to invest in 2025?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: accentRed)),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: discussionReplies.length,
            separatorBuilder: (_, __) => const Divider(
                color: dividerColor, thickness: kCardDividerThickness),
            itemBuilder: (c, i) {
              final p = discussionReplies[i];
              final isOmar = p['name'] == 'Omar Saad';
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isOmar ? 32.0 : 16.0, vertical: 12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(p['avatar']!)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p['name']!,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: primaryBlue)),
                                const SizedBox(height: 4),
                                Text(p['subtitle']!,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryBlue)),
                              ]),
                        ),
                      ]),
                      const SizedBox(height: 8),
                      Text(p['content']!),
                    ]),
              );
            },
          ),

          // --- Investment Opportunities + Metrics
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
            child: Text('Investment Opportunities',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InvestmentCardB(
              assetImage: 'assets/opportunity.png',
              title: 'Zero Sugar By Ketonista',
              description:
                  'We are specialized in Healthy, Keto, Sugar Free, Gluten Free Products',
              investedAmount: '450,000 LE',
              investors: '43',
              onTap: () {},
              onBookmarkPressed: () {},
              isSaved: false,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: opportunityMetrics.asMap().entries.map((e) {
                final idx = e.key;
                final m = e.value;
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(children: [
                      Expanded(
                          child: Text(m['label']!,
                              style: const TextStyle(color: kMetricTextColor))),
                      Text(m['value']!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kMetricTextColor)),
                    ]),
                  ),
                  if (idx != opportunityMetrics.length - 1)
                    const Divider(
                        thickness: kMetricsDividerThickness,
                        color: dividerColor),
                ]);
              }).toList(),
            ),
          ),

          // --- See more
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFD9E4FF),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Community2Screen()),
                  );
                },
                child: const Text('See more',
                    style: TextStyle(color: kMetricTextColor)),
              ),
            ]),
          ),

          const SizedBox(height: 16),

          // --- Invest button
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kInvestBtnColor,
                foregroundColor: kInvestBtnTextColor,
                fixedSize: const Size(kInvestBtnWidth, kInvestBtnHeight),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Invest'),
            ),
          ),

          const SizedBox(height: 24),
        ]),
      ),
    );
  }
}
