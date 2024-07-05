import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


class Privacypolicy extends StatelessWidget {
  const Privacypolicy ({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: GFAppBar(
        title:Text("Privacy Policy for PALM HR", style: GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),

        leading: IconButton(
          onPressed: (){
            context.go("/settings");
          },
          icon: Icon(
            Icons.arrow_back_ios_new
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(20),
            const   Text("At PALM HR, accessible from mirego.bi, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by PALM HR and how we use it."
                 " If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us."
                  "This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in mirego.bi. This policy is not applicable to any information collected offline or via channels other than this website. Our Privacy Policy was created with the help of the Free Privacy Policy Generator."),
              Gap(20),
              Text("Information we collect",style: GoogleFonts.inter(fontSize: 16)),
              Gap(10),
             const  Text("Information You Provide. When you register to the Site, use it, complete forms, participate in skills tests or surveys, or use the Site as collaborator, and/or register to our affiliate or influencer or similar program, we ask you to provide certain personal information, including a valid email address, Facebook or Google account login details and username. We will also ask you to provide or otherwise collect additional information, such as, your name, profile details, physical address or billing information, telephone number or other contact details, transactional information, payment information (for example, in certain cases we process your payment method and credit card number), taxpayer information and forms, details about other social networks linked accounts, details about your listed gigs, purchases, education, profession and expertise, information and files uploaded by you to the Site, and additional authentication information (such as copies of your government issued ID, passport, or driving license, as permitted by applicable laws and as detailed in our Seller Help Center at “Verifying Your Identity”). We also collect information about or contained in your communications with PALM HR as well as any of your posts on our blogs or forums and your communication with other users of PALM HR."
          "Information We Collect Automatically. We collect information while you access, browse, view or otherwise use the Site. In other words, when you access the Site we collect personal information on your usage of the Site, including transactions and communications with other users through the Site, your searches, the pages you visited, as well as other actions on Site. We also, collect, use and process the information relating to such usage, including geo-location information, IP address, device and connection information, browser information and web-log information, and the URLs of the web pages you’ve viewed or engaged with before or after using the Site. We also collect and process information relating to the use of cookies and similar technologies, as detailed below. We use that information to provide you our services, enhance user experience, personalize your browsing experience as well as monitor the Site for preventing fraud and inappropriate content or behaviour."
          "Additionally, in order to improve your online experience at PALM HR, we have implemented impression reporting. While you view our ads, we gather user Global Unique Identifier, HTTP request data like, user agent, IP, host, URL, country/continent from which request made, browser info, device/operating system/operating system version."
          "The personal information that you are asked to provide, and the reasons why you are asked to provide it, will be made clear to you at the point we ask you to provide your personal information."
          "If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide."
          "When you register for an Account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number.)"
              ),
              Gap(20),
              Text("How do we use the information collected",style: GoogleFonts.inter(fontSize: 16)),
              Gap(10),
              const Text(
"to provide you with quality service and security, to operate the Site, to perform our obligations to you and to develop and improve our service. For example, we use personal information to verify your identity. We also use this information to establish and set up your account, verify or re-issue a password, log your activity, enable your communications with other members, provide customer support and contact you from time to time. The information helps us to develop and improve our services, to understand and analyse our performance as well as your preferences and performance and to customize and personalize our service and enhance your experience (including by making Gig suggestions, ranking search results, etc.)."
"to ensure marketplace integrity, prevent fraud and maintain a safe and secure marketplace and services. For example, we use personal information to monitor, track and prevent fraudulent activities and other inappropriate activities, monitor content integrity, conduct security investigations and risk assessments, verify or authenticate information provided by you, enforce our Terms of Service and comply with applicable laws. We conduct certain behavioural analytics to achieve the above objectives and in limited cases, if we detect activity that we think poses a risk to the PALM HR marketplace, other users, our community, or third parties, automated processes may restrict or limit your ability to use PALM HR. If you would like to challenge any such decision, please contact us at mirego.bi."
" to contact you, as requested by you or as otherwise approved by you or permitted according to this Policy."
              "to promote and advertise the Site, our services and the PALM HRmarketplace. For example, we use the information collected from you for the purpose of sending direct marketing messages (as detailed below), to show you information that may be of interest to you, to organize and facilitate referral programs, contests or other promotional activities or events."
"We use your personal information to send you direct marketing communications about our products, services or promotions from PALM HRthat may be of interest to you or our related services. This may be via email, post, SMS, telephone or targeted online advertisements."
"How Long Do We Keep Personal Information?"
"We apply a general rule of keeping personal information only for as long as is required to fulfil the purpose for which it was collected. However, in some circumstances, we will retain your personal information for longer periods of time. We will retain personal information for the following purposes:"
"as long as it is necessary and relevant for our operations, e.g. so that we have an accurate record of your dealings with us in the event of any complaints or challenge; and"
"in relation to personal information from closed accounts to comply with applicable laws, prevent fraud, collect any fees owed, resolve disputes, troubleshoot problems, assist with any investigation, enforce our Site terms and take other actions as permitted by law."
              ),
              Gap(20),
              Text("Cookies",style: GoogleFonts.inter(fontSize: 16)),
              Gap(10),
              Text("We use cookies and similar technologies (such as web beacons, pixels, tags, and scripts) to improve and personalize your experience, provide our services, analyze website performance and for marketing purposes. To learn more about how we and our third party service providers use cookies and your control over these Cookies, please see our Cookie Policy."),
              Gap(20),

              Text("Children's Information",style: GoogleFonts.inter(fontSize: 16)),
              Gap(10),
              Text(
"Another part of our priority is adding protection for children while using the internet. We encourage parents and guardians to observe, participate in, and/or monitor and guide their online activity.mirego.bi does not knowingly collect any Personal Identifiable Information from children under the age of 13."
"If you think that your child provided this kind of information on our website, we strongly encourage you to contact us immediately and we will do our best efforts to promptly remove such information from our records."              )
            ],
          ),
        ),
      ),
    );
  }

}