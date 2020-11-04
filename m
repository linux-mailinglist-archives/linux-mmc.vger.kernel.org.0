Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BCA2A686E
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Nov 2020 16:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgKDPxx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Nov 2020 10:53:53 -0500
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:54240
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731186AbgKDPxs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Nov 2020 10:53:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWhZ8AniZ8L6tmEJfny3nNnu6edQmOkdkyie4U8EJS0H6fWEXiu++dcUBVOhoItK5A7rF0rTDx2/+9B0e/SLZUhQxdc7mSDTCJ8Uc9Pvrc0yNcfCw/wgcCr+SCh4VWpSEZ6dJepK1sjOYjt04ybLCSjYBB8DeDp0kFIVyMf3dHZhvP7lOJ+VftTJJVHMCIN0vTzCIQzfpp5fuDyCfJ088E8JRhuGQO29OZFs227YV0mbZqFmKGJyRpu/UGuMaCkLr7ja1NH/j3ogXcmjtEEjeCfYatiOmkEVrYcLM/86zQDyhhf8AWbAIpoO8Y2/r25NCurFX47YkjSwiZrTL9cgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEPoAcLMuYJzkTkzf4tbDCzv6UuZwYhqeMcpodAeeHM=;
 b=JrrRMbufDzUJp3J2ZaE39ZBytBkJlJG3PxnzpIJ+OPT3TgsBgu6WDbtb4mhI8E0bioeljThd8tS5nkldXtcy3AKH6IQqdbgq9vc9nfUNqkEKx0v7wX6D97jJAL/RXhZuy2QZvM9WIKO8XzMK6EFwp8QMe195hmpacWay/IsQj0y8Rp/6G5ly7/aDqKnzNIbW3yD3MM85t3SsVWMKzsZtjFx5awE5N4B5LpBCfzB6e+m0bTaHVFcicZqQyK3IvrDHih8AyfV3KFqhCOjXliM4nd1lf4dpvFWr/aI+hAp9psLBFumeCRlZUvrOo8CKXzShNSGzGep/fE/0JvL9AAlP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEPoAcLMuYJzkTkzf4tbDCzv6UuZwYhqeMcpodAeeHM=;
 b=jtrS07I6GdINQ6em5wK/0bxZ7bMcmP/9UOxlSp1PIfT429TfcjMKJwEjZi2FNEKXOEKTAygVuPI75cBul6UdW18hTNNNiO7asnKKjSpUwatBJ/0DtKpE8jBj0fzZAVrlWFyJKCfaX/U6beAiUI1nIG6yaCakBAwgP0RChXDGoBU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32; Wed, 4 Nov
 2020 15:53:02 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::4f5:fbe5:44a7:cb8a]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::4f5:fbe5:44a7:cb8a%5]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:53:02 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v3 18/24] wfx: add data_tx.c/data_tx.h
Date:   Wed,  4 Nov 2020 16:52:01 +0100
Message-Id: <20201104155207.128076-19-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104155207.128076-1-Jerome.Pouiller@silabs.com>
References: <20201104155207.128076-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Originating-IP: [82.67.86.106]
X-ClientProxiedBy: SN6PR01CA0032.prod.exchangelabs.com (2603:10b6:805:b6::45)
 To SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.silabs.com (82.67.86.106) by SN6PR01CA0032.prod.exchangelabs.com (2603:10b6:805:b6::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 15:53:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45a785c8-84b0-4422-6358-08d880d9b62a
X-MS-TrafficTypeDiagnostic: SN6PR11MB2718:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB27184ED89B12A1E3B16CCE7C93EF0@SN6PR11MB2718.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hFaq8hEaHgSdo8RMHqWGJQJJBVx7on2+7wzN6nSoQLiaocd5BNA2W0LDIk/psA77hFv1Ecrx4sWl/4pYRgz9BIX9GSa+/sbPJORW8piuAiSe9ofgb2fAMdghXz7tf/FR9eBTM/8trw6L2fZx02xRTGlabUQiitfwvIzDyMrC0RbLL8Ije0qq1rrs1ibKjkzhC4F8mEOKN5pdqsAGQ1cEq0KkFV+qnj38Fv0JcwhWMHjadJ7QvwR2OCsckAv4xBE6kvx+FL9MXAzkfCbJR4Iq5j0MkTsJ794ZXzdwyNIcVEOCloAIMOnlFRTeqCm0UEOaBoED5TzEDtw5em6puAj53g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39850400004)(136003)(396003)(8936002)(478600001)(186003)(16526019)(956004)(2616005)(6486002)(8676002)(66574015)(66476007)(66556008)(66946007)(316002)(7696005)(83380400001)(26005)(54906003)(107886003)(30864003)(36756003)(52116002)(7416002)(4326008)(5660300002)(86362001)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eWgBd7CqUPS8Z/dLBh5mASR3rbinIcuwO/6AnAmm29eluxE53PuAgjmqKw1UE3Hvic/CUouSP37gURHg7RR1ketOq7MQv6vaJADs62D1bhPXQFJopPYMUmrddRO5EBjze5zYEwgC+foHTZ9l7+sVTWUlU41ywCnNLXmOsyOeVtSRsLB7cZc/0LD6yb+gVDyvb85oKHsljkKU5UWjOi+VscZzNDSI1Se15lM+sTvwPxKfChqTB8XDQYpF2R3nX/Gz3ZOeGyQNVPJv3raTAm07KwiHpuFzJqmW5ERLMX82Yw4t46WL3ZEIbeC92Fohi1Ij3QHGeaMsuloJKteJZpfNSM2V8HmWkyOlOBmZviHUk+gUIwsq6/sYUwV66ggT38DCz7cV8y37VfVXRGs2m8qaXIXTqfq2IWXLzQhSC+wFL/f5rU/ak2W54u7JIdxSOABpwUaVD6LBNkAUvwmSZdEVdiCk+2i4XcQj87roNhjBvJb6tFUxRvrbW42JBFukYJZvgLHw0GmF3YjR0hnp9rV+Lxyvdg3JnyGaDfETKCQ4n7SNPqGer2isDjM0xHlxDmqa6EzN3UtFB0TkBSscjJg22dkAoW7EzZcW+jCRCu+jgfu8z4lrCtO4sUA/D+jjNpCdgh+QenF1DGccM1B0jajwlQ==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a785c8-84b0-4422-6358-08d880d9b62a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:53:02.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyE8fEKdlG3g+xmGFzLurMT7k9amGzgwhmTaxwA+E4bmfg4BiXtQ0gXz5Goo1LaGH65EmsZ32QYEp2hACX03Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2718
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0YV90eC5jIHwgNTg1ICsr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0
YV90eC5oIHwgIDY3ICsrKwogMiBmaWxlcyBjaGFuZ2VkLCA2NTIgaW5zZXJ0aW9ucygrKQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0YV90eC5j
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9kYXRh
X3R4LmgKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFf
dHguYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0YV90eC5jCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uMmY0OWRhN2NkNTM4Ci0tLSAvZGV2L251
bGwKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9kYXRhX3R4LmMKQEAgLTAs
MCArMSw1ODUgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKKy8q
CisgKiBEYXRhcGF0aCBpbXBsZW1lbnRhdGlvbi4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTct
MjAyMCwgU2lsaWNvbiBMYWJvcmF0b3JpZXMsIEluYy4KKyAqIENvcHlyaWdodCAoYykgMjAxMCwg
U1QtRXJpY3Nzb24KKyAqLworI2luY2x1ZGUgPG5ldC9tYWM4MDIxMS5oPgorI2luY2x1ZGUgPGxp
bnV4L2V0aGVyZGV2aWNlLmg+CisKKyNpbmNsdWRlICJkYXRhX3R4LmgiCisjaW5jbHVkZSAid2Z4
LmgiCisjaW5jbHVkZSAiYmguaCIKKyNpbmNsdWRlICJzdGEuaCIKKyNpbmNsdWRlICJxdWV1ZS5o
IgorI2luY2x1ZGUgImRlYnVnLmgiCisjaW5jbHVkZSAidHJhY2VzLmgiCisjaW5jbHVkZSAiaGlm
X3R4X21pYi5oIgorCitzdGF0aWMgaW50IHdmeF9nZXRfaHdfcmF0ZShzdHJ1Y3Qgd2Z4X2RldiAq
d2RldiwKKwkJCSAgIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfdHhfcmF0ZSAqcmF0ZSkKK3sKKwlz
dHJ1Y3QgaWVlZTgwMjExX3N1cHBvcnRlZF9iYW5kICpiYW5kOworCisJaWYgKHJhdGUtPmlkeCA8
IDApCisJCXJldHVybiAtMTsKKwlpZiAocmF0ZS0+ZmxhZ3MgJiBJRUVFODAyMTFfVFhfUkNfTUNT
KSB7CisJCWlmIChyYXRlLT5pZHggPiA3KSB7CisJCQlXQVJOKDEsICJ3cm9uZyByYXRlLT5pZHgg
dmFsdWU6ICVkIiwgcmF0ZS0+aWR4KTsKKwkJCXJldHVybiAtMTsKKwkJfQorCQlyZXR1cm4gcmF0
ZS0+aWR4ICsgMTQ7CisJfQorCS8vIFdGeCBvbmx5IHN1cHBvcnQgMkdIeiwgZWxzZSBiYW5kIGlu
Zm9ybWF0aW9uIHNob3VsZCBiZSByZXRyaWV2ZWQKKwkvLyBmcm9tIGllZWU4MDIxMV90eF9pbmZv
CisJYmFuZCA9IHdkZXYtPmh3LT53aXBoeS0+YmFuZHNbTkw4MDIxMV9CQU5EXzJHSFpdOworCWlm
IChyYXRlLT5pZHggPj0gYmFuZC0+bl9iaXRyYXRlcykgeworCQlXQVJOKDEsICJ3cm9uZyByYXRl
LT5pZHggdmFsdWU6ICVkIiwgcmF0ZS0+aWR4KTsKKwkJcmV0dXJuIC0xOworCX0KKwlyZXR1cm4g
YmFuZC0+Yml0cmF0ZXNbcmF0ZS0+aWR4XS5od192YWx1ZTsKK30KKworLyogVFggcG9saWN5IGNh
Y2hlIGltcGxlbWVudGF0aW9uICovCisKK3N0YXRpYyB2b2lkIHdmeF90eF9wb2xpY3lfYnVpbGQo
c3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCB0eF9wb2xpY3kgKnBvbGljeSwKKwkJCQlzdHJ1
Y3QgaWVlZTgwMjExX3R4X3JhdGUgKnJhdGVzKQoreworCXN0cnVjdCB3ZnhfZGV2ICp3ZGV2ID0g
d3ZpZi0+d2RldjsKKwlpbnQgaSwgcmF0ZWlkOworCXU4IGNvdW50OworCisJV0FSTihyYXRlc1sw
XS5pZHggPCAwLCAiaW52YWxpZCByYXRlIHBvbGljeSIpOworCW1lbXNldChwb2xpY3ksIDAsIHNp
emVvZigqcG9saWN5KSk7CisJZm9yIChpID0gMDsgaSA8IElFRUU4MDIxMV9UWF9NQVhfUkFURVM7
ICsraSkgeworCQlpZiAocmF0ZXNbaV0uaWR4IDwgMCkKKwkJCWJyZWFrOworCQlXQVJOX09OKHJh
dGVzW2ldLmNvdW50ID4gMTUpOworCQlyYXRlaWQgPSB3ZnhfZ2V0X2h3X3JhdGUod2RldiwgJnJh
dGVzW2ldKTsKKwkJLy8gUGFjayB0d28gdmFsdWVzIGluIGVhY2ggYnl0ZSBvZiBwb2xpY3ktPnJh
dGVzCisJCWNvdW50ID0gcmF0ZXNbaV0uY291bnQ7CisJCWlmIChyYXRlaWQgJSAyKQorCQkJY291
bnQgPDw9IDQ7CisJCXBvbGljeS0+cmF0ZXNbcmF0ZWlkIC8gMl0gfD0gY291bnQ7CisJfQorfQor
CitzdGF0aWMgYm9vbCB0eF9wb2xpY3lfaXNfZXF1YWwoY29uc3Qgc3RydWN0IHR4X3BvbGljeSAq
YSwKKwkJCSAgICAgICBjb25zdCBzdHJ1Y3QgdHhfcG9saWN5ICpiKQoreworCXJldHVybiAhbWVt
Y21wKGEtPnJhdGVzLCBiLT5yYXRlcywgc2l6ZW9mKGEtPnJhdGVzKSk7Cit9CisKK3N0YXRpYyBp
bnQgd2Z4X3R4X3BvbGljeV9maW5kKHN0cnVjdCB0eF9wb2xpY3lfY2FjaGUgKmNhY2hlLAorCQkJ
ICAgICAgc3RydWN0IHR4X3BvbGljeSAqd2FudGVkKQoreworCXN0cnVjdCB0eF9wb2xpY3kgKml0
OworCisJbGlzdF9mb3JfZWFjaF9lbnRyeShpdCwgJmNhY2hlLT51c2VkLCBsaW5rKQorCQlpZiAo
dHhfcG9saWN5X2lzX2VxdWFsKHdhbnRlZCwgaXQpKQorCQkJcmV0dXJuIGl0IC0gY2FjaGUtPmNh
Y2hlOworCWxpc3RfZm9yX2VhY2hfZW50cnkoaXQsICZjYWNoZS0+ZnJlZSwgbGluaykKKwkJaWYg
KHR4X3BvbGljeV9pc19lcXVhbCh3YW50ZWQsIGl0KSkKKwkJCXJldHVybiBpdCAtIGNhY2hlLT5j
YWNoZTsKKwlyZXR1cm4gLTE7Cit9CisKK3N0YXRpYyB2b2lkIHdmeF90eF9wb2xpY3lfdXNlKHN0
cnVjdCB0eF9wb2xpY3lfY2FjaGUgKmNhY2hlLAorCQkJICAgICAgc3RydWN0IHR4X3BvbGljeSAq
ZW50cnkpCit7CisJKytlbnRyeS0+dXNhZ2VfY291bnQ7CisJbGlzdF9tb3ZlKCZlbnRyeS0+bGlu
aywgJmNhY2hlLT51c2VkKTsKK30KKworc3RhdGljIGludCB3ZnhfdHhfcG9saWN5X3JlbGVhc2Uo
c3RydWN0IHR4X3BvbGljeV9jYWNoZSAqY2FjaGUsCisJCQkJIHN0cnVjdCB0eF9wb2xpY3kgKmVu
dHJ5KQoreworCWludCByZXQgPSAtLWVudHJ5LT51c2FnZV9jb3VudDsKKworCWlmICghcmV0KQor
CQlsaXN0X21vdmUoJmVudHJ5LT5saW5rLCAmY2FjaGUtPmZyZWUpOworCXJldHVybiByZXQ7Cit9
CisKK3N0YXRpYyBpbnQgd2Z4X3R4X3BvbGljeV9nZXQoc3RydWN0IHdmeF92aWYgKnd2aWYsCisJ
CQkgICAgIHN0cnVjdCBpZWVlODAyMTFfdHhfcmF0ZSAqcmF0ZXMsIGJvb2wgKnJlbmV3KQorewor
CWludCBpZHg7CisJc3RydWN0IHR4X3BvbGljeV9jYWNoZSAqY2FjaGUgPSAmd3ZpZi0+dHhfcG9s
aWN5X2NhY2hlOworCXN0cnVjdCB0eF9wb2xpY3kgd2FudGVkOworCisJd2Z4X3R4X3BvbGljeV9i
dWlsZCh3dmlmLCAmd2FudGVkLCByYXRlcyk7CisKKwlzcGluX2xvY2tfYmgoJmNhY2hlLT5sb2Nr
KTsKKwlpZiAobGlzdF9lbXB0eSgmY2FjaGUtPmZyZWUpKSB7CisJCVdBUk4oMSwgInVuYWJsZSB0
byBnZXQgYSB2YWxpZCBUeCBwb2xpY3kiKTsKKwkJc3Bpbl91bmxvY2tfYmgoJmNhY2hlLT5sb2Nr
KTsKKwkJcmV0dXJuIEhJRl9UWF9SRVRSWV9QT0xJQ1lfSU5WQUxJRDsKKwl9CisJaWR4ID0gd2Z4
X3R4X3BvbGljeV9maW5kKGNhY2hlLCAmd2FudGVkKTsKKwlpZiAoaWR4ID49IDApIHsKKwkJKnJl
bmV3ID0gZmFsc2U7CisJfSBlbHNlIHsKKwkJc3RydWN0IHR4X3BvbGljeSAqZW50cnk7CisJCSpy
ZW5ldyA9IHRydWU7CisJCS8qIElmIHBvbGljeSBpcyBub3QgZm91bmQgY3JlYXRlIGEgbmV3IG9u
ZQorCQkgKiB1c2luZyB0aGUgb2xkZXN0IGVudHJ5IGluICJmcmVlIiBsaXN0CisJCSAqLworCQll
bnRyeSA9IGxpc3RfZW50cnkoY2FjaGUtPmZyZWUucHJldiwgc3RydWN0IHR4X3BvbGljeSwgbGlu
ayk7CisJCW1lbWNweShlbnRyeS0+cmF0ZXMsIHdhbnRlZC5yYXRlcywgc2l6ZW9mKGVudHJ5LT5y
YXRlcykpOworCQllbnRyeS0+dXBsb2FkZWQgPSBmYWxzZTsKKwkJZW50cnktPnVzYWdlX2NvdW50
ID0gMDsKKwkJaWR4ID0gZW50cnkgLSBjYWNoZS0+Y2FjaGU7CisJfQorCXdmeF90eF9wb2xpY3lf
dXNlKGNhY2hlLCAmY2FjaGUtPmNhY2hlW2lkeF0pOworCWlmIChsaXN0X2VtcHR5KCZjYWNoZS0+
ZnJlZSkpCisJCWllZWU4MDIxMV9zdG9wX3F1ZXVlcyh3dmlmLT53ZGV2LT5odyk7CisJc3Bpbl91
bmxvY2tfYmgoJmNhY2hlLT5sb2NrKTsKKwlyZXR1cm4gaWR4OworfQorCitzdGF0aWMgdm9pZCB3
ZnhfdHhfcG9saWN5X3B1dChzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwgaW50IGlkeCkKK3sKKwlpbnQg
dXNhZ2UsIGxvY2tlZDsKKwlzdHJ1Y3QgdHhfcG9saWN5X2NhY2hlICpjYWNoZSA9ICZ3dmlmLT50
eF9wb2xpY3lfY2FjaGU7CisKKwlpZiAoaWR4ID09IEhJRl9UWF9SRVRSWV9QT0xJQ1lfSU5WQUxJ
RCkKKwkJcmV0dXJuOworCXNwaW5fbG9ja19iaCgmY2FjaGUtPmxvY2spOworCWxvY2tlZCA9IGxp
c3RfZW1wdHkoJmNhY2hlLT5mcmVlKTsKKwl1c2FnZSA9IHdmeF90eF9wb2xpY3lfcmVsZWFzZShj
YWNoZSwgJmNhY2hlLT5jYWNoZVtpZHhdKTsKKwlpZiAobG9ja2VkICYmICF1c2FnZSkKKwkJaWVl
ZTgwMjExX3dha2VfcXVldWVzKHd2aWYtPndkZXYtPmh3KTsKKwlzcGluX3VubG9ja19iaCgmY2Fj
aGUtPmxvY2spOworfQorCitzdGF0aWMgaW50IHdmeF90eF9wb2xpY3lfdXBsb2FkKHN0cnVjdCB3
ZnhfdmlmICp3dmlmKQoreworCXN0cnVjdCB0eF9wb2xpY3kgKnBvbGljaWVzID0gd3ZpZi0+dHhf
cG9saWN5X2NhY2hlLmNhY2hlOworCXU4IHRtcF9yYXRlc1sxMl07CisJaW50IGksIGlzX3VzZWQ7
CisKKwlkbyB7CisJCXNwaW5fbG9ja19iaCgmd3ZpZi0+dHhfcG9saWN5X2NhY2hlLmxvY2spOwor
CQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh3dmlmLT50eF9wb2xpY3lfY2FjaGUuY2FjaGUp
OyArK2kpIHsKKwkJCWlzX3VzZWQgPSBtZW16Y21wKHBvbGljaWVzW2ldLnJhdGVzLAorCQkJCQkg
IHNpemVvZihwb2xpY2llc1tpXS5yYXRlcykpOworCQkJaWYgKCFwb2xpY2llc1tpXS51cGxvYWRl
ZCAmJiBpc191c2VkKQorCQkJCWJyZWFrOworCQl9CisJCWlmIChpIDwgQVJSQVlfU0laRSh3dmlm
LT50eF9wb2xpY3lfY2FjaGUuY2FjaGUpKSB7CisJCQlwb2xpY2llc1tpXS51cGxvYWRlZCA9IHRy
dWU7CisJCQltZW1jcHkodG1wX3JhdGVzLCBwb2xpY2llc1tpXS5yYXRlcywgc2l6ZW9mKHRtcF9y
YXRlcykpOworCQkJc3Bpbl91bmxvY2tfYmgoJnd2aWYtPnR4X3BvbGljeV9jYWNoZS5sb2NrKTsK
KwkJCWhpZl9zZXRfdHhfcmF0ZV9yZXRyeV9wb2xpY3kod3ZpZiwgaSwgdG1wX3JhdGVzKTsKKwkJ
fSBlbHNlIHsKKwkJCXNwaW5fdW5sb2NrX2JoKCZ3dmlmLT50eF9wb2xpY3lfY2FjaGUubG9jayk7
CisJCX0KKwl9IHdoaWxlIChpIDwgQVJSQVlfU0laRSh3dmlmLT50eF9wb2xpY3lfY2FjaGUuY2Fj
aGUpKTsKKwlyZXR1cm4gMDsKK30KKwordm9pZCB3ZnhfdHhfcG9saWN5X3VwbG9hZF93b3JrKHN0
cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKK3sKKwlzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiA9CisJCWNv
bnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3Qgd2Z4X3ZpZiwgdHhfcG9saWN5X3VwbG9hZF93b3JrKTsK
KworCXdmeF90eF9wb2xpY3lfdXBsb2FkKHd2aWYpOworCXdmeF90eF91bmxvY2sod3ZpZi0+d2Rl
dik7Cit9CisKK3ZvaWQgd2Z4X3R4X3BvbGljeV9pbml0KHN0cnVjdCB3ZnhfdmlmICp3dmlmKQor
eworCXN0cnVjdCB0eF9wb2xpY3lfY2FjaGUgKmNhY2hlID0gJnd2aWYtPnR4X3BvbGljeV9jYWNo
ZTsKKwlpbnQgaTsKKworCW1lbXNldChjYWNoZSwgMCwgc2l6ZW9mKCpjYWNoZSkpOworCisJc3Bp
bl9sb2NrX2luaXQoJmNhY2hlLT5sb2NrKTsKKwlJTklUX0xJU1RfSEVBRCgmY2FjaGUtPnVzZWQp
OworCUlOSVRfTElTVF9IRUFEKCZjYWNoZS0+ZnJlZSk7CisKKwlmb3IgKGkgPSAwOyBpIDwgQVJS
QVlfU0laRShjYWNoZS0+Y2FjaGUpOyArK2kpCisJCWxpc3RfYWRkKCZjYWNoZS0+Y2FjaGVbaV0u
bGluaywgJmNhY2hlLT5mcmVlKTsKK30KKworLyogVHggaW1wbGVtZW50YXRpb24gKi8KKworc3Rh
dGljIGJvb2wgaWVlZTgwMjExX2lzX2FjdGlvbl9iYWNrKHN0cnVjdCBpZWVlODAyMTFfaGRyICpo
ZHIpCit7CisJc3RydWN0IGllZWU4MDIxMV9tZ210ICptZ210ID0gKHN0cnVjdCBpZWVlODAyMTFf
bWdtdCAqKWhkcjsKKworCWlmICghaWVlZTgwMjExX2lzX2FjdGlvbihtZ210LT5mcmFtZV9jb250
cm9sKSkKKwkJcmV0dXJuIGZhbHNlOworCWlmIChtZ210LT51LmFjdGlvbi5jYXRlZ29yeSAhPSBX
TEFOX0NBVEVHT1JZX0JBQ0spCisJCXJldHVybiBmYWxzZTsKKwlyZXR1cm4gdHJ1ZTsKK30KKwor
c3RhdGljIHU4IHdmeF90eF9nZXRfbGlua19pZChzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwgc3RydWN0
IGllZWU4MDIxMV9zdGEgKnN0YSwKKwkJCSAgICAgc3RydWN0IGllZWU4MDIxMV9oZHIgKmhkcikK
K3sKKwlzdHJ1Y3Qgd2Z4X3N0YV9wcml2ICpzdGFfcHJpdiA9CisJCXN0YSA/IChzdHJ1Y3Qgd2Z4
X3N0YV9wcml2ICopJnN0YS0+ZHJ2X3ByaXYgOiBOVUxMOworCWNvbnN0IHU4ICpkYSA9IGllZWU4
MDIxMV9nZXRfREEoaGRyKTsKKworCWlmIChzdGFfcHJpdiAmJiBzdGFfcHJpdi0+bGlua19pZCkK
KwkJcmV0dXJuIHN0YV9wcml2LT5saW5rX2lkOworCWlmICh3dmlmLT52aWYtPnR5cGUgIT0gTkw4
MDIxMV9JRlRZUEVfQVApCisJCXJldHVybiAwOworCWlmIChpc19tdWx0aWNhc3RfZXRoZXJfYWRk
cihkYSkpCisJCXJldHVybiAwOworCXJldHVybiBISUZfTElOS19JRF9OT1RfQVNTT0NJQVRFRDsK
K30KKworc3RhdGljIHZvaWQgd2Z4X3R4X2ZpeHVwX3JhdGVzKHN0cnVjdCBpZWVlODAyMTFfdHhf
cmF0ZSAqcmF0ZXMpCit7CisJaW50IGk7CisJYm9vbCBmaW5pc2hlZDsKKworCS8vIEZpcm13YXJl
IGlzIG5vdCBhYmxlIHRvIG1peCByYXRlcyB3aXRoIGRpZmZlcmVudCBmbGFncworCWZvciAoaSA9
IDA7IGkgPCBJRUVFODAyMTFfVFhfTUFYX1JBVEVTOyBpKyspIHsKKwkJaWYgKHJhdGVzWzBdLmZs
YWdzICYgSUVFRTgwMjExX1RYX1JDX1NIT1JUX0dJKQorCQkJcmF0ZXNbaV0uZmxhZ3MgfD0gSUVF
RTgwMjExX1RYX1JDX1NIT1JUX0dJOworCQlpZiAoIShyYXRlc1swXS5mbGFncyAmIElFRUU4MDIx
MV9UWF9SQ19TSE9SVF9HSSkpCisJCQlyYXRlc1tpXS5mbGFncyAmPSB+SUVFRTgwMjExX1RYX1JD
X1NIT1JUX0dJOworCQlpZiAoIShyYXRlc1swXS5mbGFncyAmIElFRUU4MDIxMV9UWF9SQ19VU0Vf
UlRTX0NUUykpCisJCQlyYXRlc1tpXS5mbGFncyAmPSB+SUVFRTgwMjExX1RYX1JDX1VTRV9SVFNf
Q1RTOworCX0KKworCS8vIFNvcnQgcmF0ZXMgYW5kIHJlbW92ZSBkdXBsaWNhdGVzCisJZG8gewor
CQlmaW5pc2hlZCA9IHRydWU7CisJCWZvciAoaSA9IDA7IGkgPCBJRUVFODAyMTFfVFhfTUFYX1JB
VEVTIC0gMTsgaSsrKSB7CisJCQlpZiAocmF0ZXNbaSArIDFdLmlkeCA9PSByYXRlc1tpXS5pZHgg
JiYKKwkJCSAgICByYXRlc1tpXS5pZHggIT0gLTEpIHsKKwkJCQlyYXRlc1tpXS5jb3VudCArPSBy
YXRlc1tpICsgMV0uY291bnQ7CisJCQkJaWYgKHJhdGVzW2ldLmNvdW50ID4gMTUpCisJCQkJCXJh
dGVzW2ldLmNvdW50ID0gMTU7CisJCQkJcmF0ZXNbaSArIDFdLmlkeCA9IC0xOworCQkJCXJhdGVz
W2kgKyAxXS5jb3VudCA9IDA7CisKKwkJCQlmaW5pc2hlZCA9IGZhbHNlOworCQkJfQorCQkJaWYg
KHJhdGVzW2kgKyAxXS5pZHggPiByYXRlc1tpXS5pZHgpIHsKKwkJCQlzd2FwKHJhdGVzW2kgKyAx
XSwgcmF0ZXNbaV0pOworCQkJCWZpbmlzaGVkID0gZmFsc2U7CisJCQl9CisJCX0KKwl9IHdoaWxl
ICghZmluaXNoZWQpOworCS8vIEVuc3VyZSB0aGF0IE1DUzAgb3IgMU1icHMgaXMgcHJlc2VudCBh
dCB0aGUgZW5kIG9mIHRoZSByZXRyeSBsaXN0CisJZm9yIChpID0gMDsgaSA8IElFRUU4MDIxMV9U
WF9NQVhfUkFURVM7IGkrKykgeworCQlpZiAocmF0ZXNbaV0uaWR4ID09IDApCisJCQlicmVhazsK
KwkJaWYgKHJhdGVzW2ldLmlkeCA9PSAtMSkgeworCQkJcmF0ZXNbaV0uaWR4ID0gMDsKKwkJCXJh
dGVzW2ldLmNvdW50ID0gODsgLy8gPT0gaHctPm1heF9yYXRlX3RyaWVzCisJCQlyYXRlc1tpXS5m
bGFncyA9IHJhdGVzW2kgLSAxXS5mbGFncyAmCisJCQkJCSBJRUVFODAyMTFfVFhfUkNfTUNTOwor
CQkJYnJlYWs7CisJCX0KKwl9CisJLy8gQWxsIHJldHJpZXMgdXNlIGxvbmcgR0kKKwlmb3IgKGkg
PSAxOyBpIDwgSUVFRTgwMjExX1RYX01BWF9SQVRFUzsgaSsrKQorCQlyYXRlc1tpXS5mbGFncyAm
PSB+SUVFRTgwMjExX1RYX1JDX1NIT1JUX0dJOworfQorCitzdGF0aWMgdTggd2Z4X3R4X2dldF9y
YXRlX2lkKHN0cnVjdCB3ZnhfdmlmICp3dmlmLAorCQkJICAgICBzdHJ1Y3QgaWVlZTgwMjExX3R4
X2luZm8gKnR4X2luZm8pCit7CisJYm9vbCB0eF9wb2xpY3lfcmVuZXcgPSBmYWxzZTsKKwl1OCBy
YXRlX2lkOworCisJcmF0ZV9pZCA9IHdmeF90eF9wb2xpY3lfZ2V0KHd2aWYsCisJCQkJICAgIHR4
X2luZm8tPmRyaXZlcl9yYXRlcywgJnR4X3BvbGljeV9yZW5ldyk7CisJaWYgKHJhdGVfaWQgPT0g
SElGX1RYX1JFVFJZX1BPTElDWV9JTlZBTElEKQorCQlkZXZfd2Fybih3dmlmLT53ZGV2LT5kZXYs
ICJ1bmFibGUgdG8gZ2V0IGEgdmFsaWQgVHggcG9saWN5Iik7CisKKwlpZiAodHhfcG9saWN5X3Jl
bmV3KSB7CisJCXdmeF90eF9sb2NrKHd2aWYtPndkZXYpOworCQlpZiAoIXNjaGVkdWxlX3dvcmso
Jnd2aWYtPnR4X3BvbGljeV91cGxvYWRfd29yaykpCisJCQl3ZnhfdHhfdW5sb2NrKHd2aWYtPndk
ZXYpOworCX0KKwlyZXR1cm4gcmF0ZV9pZDsKK30KKworc3RhdGljIGludCB3ZnhfdHhfZ2V0X2Zy
YW1lX2Zvcm1hdChzdHJ1Y3QgaWVlZTgwMjExX3R4X2luZm8gKnR4X2luZm8pCit7CisJaWYgKCEo
dHhfaW5mby0+ZHJpdmVyX3JhdGVzWzBdLmZsYWdzICYgSUVFRTgwMjExX1RYX1JDX01DUykpCisJ
CXJldHVybiBISUZfRlJBTUVfRk9STUFUX05PTl9IVDsKKwllbHNlIGlmICghKHR4X2luZm8tPmRy
aXZlcl9yYXRlc1swXS5mbGFncyAmIElFRUU4MDIxMV9UWF9SQ19HUkVFTl9GSUVMRCkpCisJCXJl
dHVybiBISUZfRlJBTUVfRk9STUFUX01JWEVEX0ZPUk1BVF9IVDsKKwllbHNlCisJCXJldHVybiBI
SUZfRlJBTUVfRk9STUFUX0dGX0hUXzExTjsKK30KKworc3RhdGljIGludCB3ZnhfdHhfZ2V0X2lj
dl9sZW4oc3RydWN0IGllZWU4MDIxMV9rZXlfY29uZiAqaHdfa2V5KQoreworCWludCBtaWNfc3Bh
Y2U7CisKKwlpZiAoIWh3X2tleSkKKwkJcmV0dXJuIDA7CisJaWYgKGh3X2tleS0+Y2lwaGVyID09
IFdMQU5fQ0lQSEVSX1NVSVRFX0FFU19DTUFDKQorCQlyZXR1cm4gMDsKKwltaWNfc3BhY2UgPSAo
aHdfa2V5LT5jaXBoZXIgPT0gV0xBTl9DSVBIRVJfU1VJVEVfVEtJUCkgPyA4IDogMDsKKwlyZXR1
cm4gaHdfa2V5LT5pY3ZfbGVuICsgbWljX3NwYWNlOworfQorCitzdGF0aWMgaW50IHdmeF90eF9p
bm5lcihzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwgc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YSwKKwkJ
CXN0cnVjdCBza19idWZmICpza2IpCit7CisJc3RydWN0IGhpZl9tc2cgKmhpZl9tc2c7CisJc3Ry
dWN0IGhpZl9yZXFfdHggKnJlcTsKKwlzdHJ1Y3QgaWVlZTgwMjExX3R4X2luZm8gKnR4X2luZm8g
PSBJRUVFODAyMTFfU0tCX0NCKHNrYik7CisJc3RydWN0IGllZWU4MDIxMV9rZXlfY29uZiAqaHdf
a2V5ID0gdHhfaW5mby0+Y29udHJvbC5od19rZXk7CisJc3RydWN0IGllZWU4MDIxMV9oZHIgKmhk
ciA9IChzdHJ1Y3QgaWVlZTgwMjExX2hkciAqKXNrYi0+ZGF0YTsKKwlpbnQgcXVldWVfaWQgPSBz
a2JfZ2V0X3F1ZXVlX21hcHBpbmcoc2tiKTsKKwlzaXplX3Qgb2Zmc2V0ID0gKHNpemVfdClza2It
PmRhdGEgJiAzOworCWludCB3bXNnX2xlbiA9IHNpemVvZihzdHJ1Y3QgaGlmX21zZykgKworCQkJ
c2l6ZW9mKHN0cnVjdCBoaWZfcmVxX3R4KSArIG9mZnNldDsKKworCVdBUk4ocXVldWVfaWQgPj0g
SUVFRTgwMjExX05VTV9BQ1MsICJ1bnN1cHBvcnRlZCBxdWV1ZV9pZCIpOworCXdmeF90eF9maXh1
cF9yYXRlcyh0eF9pbmZvLT5kcml2ZXJfcmF0ZXMpOworCisJLy8gRnJvbSBub3cgdHhfaW5mby0+
Y29udHJvbCBpcyB1bnVzYWJsZQorCW1lbXNldCh0eF9pbmZvLT5yYXRlX2RyaXZlcl9kYXRhLCAw
LCBzaXplb2Yoc3RydWN0IHdmeF90eF9wcml2KSk7CisKKwkvLyBGaWxsIGhpZl9tc2cKKwlXQVJO
KHNrYl9oZWFkcm9vbShza2IpIDwgd21zZ19sZW4sICJub3QgZW5vdWdoIHNwYWNlIGluIHNrYiIp
OworCVdBUk4ob2Zmc2V0ICYgMSwgImF0dGVtcHQgdG8gdHJhbnNtaXQgYW4gdW5hbGlnbmVkIGZy
YW1lIik7CisJc2tiX3B1dChza2IsIHdmeF90eF9nZXRfaWN2X2xlbihod19rZXkpKTsKKwlza2Jf
cHVzaChza2IsIHdtc2dfbGVuKTsKKwltZW1zZXQoc2tiLT5kYXRhLCAwLCB3bXNnX2xlbik7CisJ
aGlmX21zZyA9IChzdHJ1Y3QgaGlmX21zZyAqKXNrYi0+ZGF0YTsKKwloaWZfbXNnLT5sZW4gPSBj
cHVfdG9fbGUxNihza2ItPmxlbik7CisJaGlmX21zZy0+aWQgPSBISUZfUkVRX0lEX1RYOworCWhp
Zl9tc2ctPmludGVyZmFjZSA9IHd2aWYtPmlkOworCWlmIChza2ItPmxlbiA+IHd2aWYtPndkZXYt
Pmh3X2NhcHMuc2l6ZV9pbnBfY2hfYnVmKSB7CisJCWRldl93YXJuKHd2aWYtPndkZXYtPmRldiwK
KwkJCSAicmVxdWVzdGVkIGZyYW1lIHNpemUgKCVkKSBpcyBsYXJnZXIgdGhhbiBtYXhpbXVtIHN1
cHBvcnRlZCAoJWQpXG4iLAorCQkJIHNrYi0+bGVuLCB3dmlmLT53ZGV2LT5od19jYXBzLnNpemVf
aW5wX2NoX2J1Zik7CisJCXNrYl9wdWxsKHNrYiwgd21zZ19sZW4pOworCQlyZXR1cm4gLUVJTzsK
Kwl9CisKKwkvLyBGaWxsIHR4IHJlcXVlc3QKKwlyZXEgPSAoc3RydWN0IGhpZl9yZXFfdHggKilo
aWZfbXNnLT5ib2R5OworCS8vIHBhY2tldF9pZCBqdXN0IG5lZWQgdG8gYmUgdW5pcXVlIG9uIGRl
dmljZS4gMzJiaXRzIGFyZSBtb3JlIHRoYW4KKwkvLyBuZWNlc3NhcnkgZm9yIHRoYXQgdGFzaywg
c28gd2UgdGFlIGFkdmFudGFnZSBvZiBpdCB0byBhZGQgc29tZSBleHRyYQorCS8vIGRhdGEgZm9y
IGRlYnVnLgorCXJlcS0+cGFja2V0X2lkID0gYXRvbWljX2FkZF9yZXR1cm4oMSwgJnd2aWYtPndk
ZXYtPnBhY2tldF9pZCkgJiAweEZGRkY7CisJcmVxLT5wYWNrZXRfaWQgfD0gSUVFRTgwMjExX1NF
UV9UT19TTihsZTE2X3RvX2NwdShoZHItPnNlcV9jdHJsKSkgPDwgMTY7CisJcmVxLT5wYWNrZXRf
aWQgfD0gcXVldWVfaWQgPDwgMjg7CisKKwlyZXEtPmZjX29mZnNldCA9IG9mZnNldDsKKwlpZiAo
dHhfaW5mby0+ZmxhZ3MgJiBJRUVFODAyMTFfVFhfQ1RMX1NFTkRfQUZURVJfRFRJTSkKKwkJcmVx
LT5hZnRlcl9kdGltID0gMTsKKwlyZXEtPnBlZXJfc3RhX2lkID0gd2Z4X3R4X2dldF9saW5rX2lk
KHd2aWYsIHN0YSwgaGRyKTsKKwkvLyBRdWV1ZSBpbmRleCBhcmUgaW52ZXJ0ZWQgYmV0d2VlbiBm
aXJtd2FyZSBhbmQgTGludXgKKwlyZXEtPnF1ZXVlX2lkID0gMyAtIHF1ZXVlX2lkOworCXJlcS0+
cmV0cnlfcG9saWN5X2luZGV4ID0gd2Z4X3R4X2dldF9yYXRlX2lkKHd2aWYsIHR4X2luZm8pOwor
CXJlcS0+ZnJhbWVfZm9ybWF0ID0gd2Z4X3R4X2dldF9mcmFtZV9mb3JtYXQodHhfaW5mbyk7CisJ
aWYgKHR4X2luZm8tPmRyaXZlcl9yYXRlc1swXS5mbGFncyAmIElFRUU4MDIxMV9UWF9SQ19TSE9S
VF9HSSkKKwkJcmVxLT5zaG9ydF9naSA9IDE7CisKKwkvLyBBdXhpbGlhcnkgb3BlcmF0aW9ucwor
CXdmeF90eF9xdWV1ZXNfcHV0KHd2aWYsIHNrYik7CisJaWYgKHR4X2luZm8tPmZsYWdzICYgSUVF
RTgwMjExX1RYX0NUTF9TRU5EX0FGVEVSX0RUSU0pCisJCXNjaGVkdWxlX3dvcmsoJnd2aWYtPnVw
ZGF0ZV90aW1fd29yayk7CisJd2Z4X2JoX3JlcXVlc3RfdHgod3ZpZi0+d2Rldik7CisJcmV0dXJu
IDA7Cit9CisKK3ZvaWQgd2Z4X3R4KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVl
ZTgwMjExX3R4X2NvbnRyb2wgKmNvbnRyb2wsCisJICAgIHN0cnVjdCBza19idWZmICpza2IpCit7
CisJc3RydWN0IHdmeF9kZXYgKndkZXYgPSBody0+cHJpdjsKKwlzdHJ1Y3Qgd2Z4X3ZpZiAqd3Zp
ZjsKKwlzdHJ1Y3QgaWVlZTgwMjExX3N0YSAqc3RhID0gY29udHJvbCA/IGNvbnRyb2wtPnN0YSA6
IE5VTEw7CisJc3RydWN0IGllZWU4MDIxMV90eF9pbmZvICp0eF9pbmZvID0gSUVFRTgwMjExX1NL
Ql9DQihza2IpOworCXN0cnVjdCBpZWVlODAyMTFfaGRyICpoZHIgPSAoc3RydWN0IGllZWU4MDIx
MV9oZHIgKilza2ItPmRhdGE7CisJc2l6ZV90IGRyaXZlcl9kYXRhX3Jvb20gPSBzaXplb2ZfZmll
bGQoc3RydWN0IGllZWU4MDIxMV90eF9pbmZvLAorCQkJCQkgICAgICAgcmF0ZV9kcml2ZXJfZGF0
YSk7CisKKwljb21waWxldGltZV9hc3NlcnQoc2l6ZW9mKHN0cnVjdCB3ZnhfdHhfcHJpdikgPD0g
ZHJpdmVyX2RhdGFfcm9vbSwKKwkJCSAgICJzdHJ1Y3QgdHhfcHJpdiBpcyB0b28gbGFyZ2UiKTsK
KwlXQVJOKHNrYi0+bmV4dCB8fCBza2ItPnByZXYsICJza2IgaXMgYWxyZWFkeSBtZW1iZXIgb2Yg
YSBsaXN0Iik7CisJLy8gY29udHJvbC52aWYgY2FuIGJlIE5VTEwgZm9yIGluamVjdGVkIGZyYW1l
cworCWlmICh0eF9pbmZvLT5jb250cm9sLnZpZikKKwkJd3ZpZiA9IChzdHJ1Y3Qgd2Z4X3ZpZiAq
KXR4X2luZm8tPmNvbnRyb2wudmlmLT5kcnZfcHJpdjsKKwllbHNlCisJCXd2aWYgPSB3dmlmX2l0
ZXJhdGUod2RldiwgTlVMTCk7CisJaWYgKFdBUk5fT04oIXd2aWYpKQorCQlnb3RvIGRyb3A7CisJ
Ly8gQmVjYXVzZSBvZiBUWF9BTVBEVV9TRVRVUF9JTl9IVywgbWFjODAyMTEgZG9lcyBub3QgdHJ5
IHRvIHNlbmQgYW55CisJLy8gQmxvY2tBY2sgc2Vzc2lvbiBtYW5hZ2VtZW50IGZyYW1lLiBUaGUg
Y2hlY2sgYmVsb3cgZXhpc3QganVzdCBpbiBjYXNlLgorCWlmIChpZWVlODAyMTFfaXNfYWN0aW9u
X2JhY2soaGRyKSkgeworCQlkZXZfaW5mbyh3ZGV2LT5kZXYsICJkcm9wIEJBIGFjdGlvblxuIik7
CisJCWdvdG8gZHJvcDsKKwl9CisJaWYgKHdmeF90eF9pbm5lcih3dmlmLCBzdGEsIHNrYikpCisJ
CWdvdG8gZHJvcDsKKworCXJldHVybjsKKworZHJvcDoKKwlpZWVlODAyMTFfdHhfc3RhdHVzX2ly
cXNhZmUod2Rldi0+aHcsIHNrYik7Cit9CisKK3N0YXRpYyB2b2lkIHdmeF9za2JfZHRvcihzdHJ1
Y3Qgd2Z4X3ZpZiAqd3ZpZiwgc3RydWN0IHNrX2J1ZmYgKnNrYikKK3sKKwlzdHJ1Y3QgaGlmX21z
ZyAqaGlmID0gKHN0cnVjdCBoaWZfbXNnICopc2tiLT5kYXRhOworCXN0cnVjdCBoaWZfcmVxX3R4
ICpyZXEgPSAoc3RydWN0IGhpZl9yZXFfdHggKiloaWYtPmJvZHk7CisJdW5zaWduZWQgaW50IG9m
ZnNldCA9IHNpemVvZihzdHJ1Y3QgaGlmX21zZykgKworCQkJICAgICAgc2l6ZW9mKHN0cnVjdCBo
aWZfcmVxX3R4KSArCisJCQkgICAgICByZXEtPmZjX29mZnNldDsKKworCWlmICghd3ZpZikgewor
CQlwcl93YXJuKCJ2aWYgYXNzb2NpYXRlZCB3aXRoIHRoZSBza2IgZG9lcyBub3QgZXhpc3QgYW55
bW9yZVxuIik7CisJCXJldHVybjsKKwl9CisJd2Z4X3R4X3BvbGljeV9wdXQod3ZpZiwgcmVxLT5y
ZXRyeV9wb2xpY3lfaW5kZXgpOworCXNrYl9wdWxsKHNrYiwgb2Zmc2V0KTsKKwlpZWVlODAyMTFf
dHhfc3RhdHVzX2lycXNhZmUod3ZpZi0+d2Rldi0+aHcsIHNrYik7Cit9CisKK3N0YXRpYyB2b2lk
IHdmeF90eF9maWxsX3JhdGVzKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LAorCQkJICAgICAgc3RydWN0
IGllZWU4MDIxMV90eF9pbmZvICp0eF9pbmZvLAorCQkJICAgICAgY29uc3Qgc3RydWN0IGhpZl9j
bmZfdHggKmFyZykKK3sKKwlzdHJ1Y3QgaWVlZTgwMjExX3R4X3JhdGUgKnJhdGU7CisJaW50IHR4
X2NvdW50OworCWludCBpOworCisJdHhfY291bnQgPSBhcmctPmFja19mYWlsdXJlczsKKwlpZiAo
IWFyZy0+c3RhdHVzIHx8IGFyZy0+YWNrX2ZhaWx1cmVzKQorCQl0eF9jb3VudCArPSAxOyAvLyBB
bHNvIHJlcG9ydCBzdWNjZXNzCisJZm9yIChpID0gMDsgaSA8IElFRUU4MDIxMV9UWF9NQVhfUkFU
RVM7IGkrKykgeworCQlyYXRlID0gJnR4X2luZm8tPnN0YXR1cy5yYXRlc1tpXTsKKwkJaWYgKHJh
dGUtPmlkeCA8IDApCisJCQlicmVhazsKKwkJaWYgKHR4X2NvdW50IDwgcmF0ZS0+Y291bnQgJiYK
KwkJICAgIGFyZy0+c3RhdHVzID09IEhJRl9TVEFUVVNfVFhfRkFJTF9SRVRSSUVTICYmCisJCSAg
ICBhcmctPmFja19mYWlsdXJlcykKKwkJCWRldl9kYmcod2Rldi0+ZGV2LCAiYWxsIHJldHJpZXMg
d2VyZSBub3QgY29uc3VtZWQ6ICVkICE9ICVkXG4iLAorCQkJCXJhdGUtPmNvdW50LCB0eF9jb3Vu
dCk7CisJCWlmICh0eF9jb3VudCA8PSByYXRlLT5jb3VudCAmJiB0eF9jb3VudCAmJgorCQkgICAg
YXJnLT50eGVkX3JhdGUgIT0gd2Z4X2dldF9od19yYXRlKHdkZXYsIHJhdGUpKQorCQkJZGV2X2Ri
Zyh3ZGV2LT5kZXYsICJpbmNvbnNpc3RlbnQgdHhfaW5mbyByYXRlczogJWQgIT0gJWRcbiIsCisJ
CQkJYXJnLT50eGVkX3JhdGUsIHdmeF9nZXRfaHdfcmF0ZSh3ZGV2LCByYXRlKSk7CisJCWlmICh0
eF9jb3VudCA+IHJhdGUtPmNvdW50KSB7CisJCQl0eF9jb3VudCAtPSByYXRlLT5jb3VudDsKKwkJ
fSBlbHNlIGlmICghdHhfY291bnQpIHsKKwkJCXJhdGUtPmNvdW50ID0gMDsKKwkJCXJhdGUtPmlk
eCA9IC0xOworCQl9IGVsc2UgeworCQkJcmF0ZS0+Y291bnQgPSB0eF9jb3VudDsKKwkJCXR4X2Nv
dW50ID0gMDsKKwkJfQorCX0KKwlpZiAodHhfY291bnQpCisJCWRldl9kYmcod2Rldi0+ZGV2LCAi
JWQgbW9yZSByZXRyaWVzIHRoYW4gZXhwZWN0ZWRcbiIsIHR4X2NvdW50KTsKK30KKwordm9pZCB3
ZnhfdHhfY29uZmlybV9jYihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgY29uc3Qgc3RydWN0IGhpZl9j
bmZfdHggKmFyZykKK3sKKwlzdHJ1Y3QgaWVlZTgwMjExX3R4X2luZm8gKnR4X2luZm87CisJc3Ry
dWN0IHdmeF92aWYgKnd2aWY7CisJc3RydWN0IHNrX2J1ZmYgKnNrYjsKKworCXNrYiA9IHdmeF9w
ZW5kaW5nX2dldCh3ZGV2LCBhcmctPnBhY2tldF9pZCk7CisJaWYgKCFza2IpIHsKKwkJZGV2X3dh
cm4od2Rldi0+ZGV2LCAicmVjZWl2ZWQgdW5rbm93biBwYWNrZXRfaWQgKCUjLjh4KSBmcm9tIGNo
aXBcbiIsCisJCQkgYXJnLT5wYWNrZXRfaWQpOworCQlyZXR1cm47CisJfQorCXR4X2luZm8gPSBJ
RUVFODAyMTFfU0tCX0NCKHNrYik7CisJd3ZpZiA9IHdkZXZfdG9fd3ZpZih3ZGV2LCAoKHN0cnVj
dCBoaWZfbXNnICopc2tiLT5kYXRhKS0+aW50ZXJmYWNlKTsKKwlXQVJOX09OKCF3dmlmKTsKKwlp
ZiAoIXd2aWYpCisJCXJldHVybjsKKworCS8vIE5vdGUgdGhhdCB3ZnhfcGVuZGluZ19nZXRfcGt0
X3VzX2RlbGF5KCkgZ2V0IGRhdGEgZnJvbSB0eF9pbmZvCisJX3RyYWNlX3R4X3N0YXRzKGFyZywg
c2tiLCB3ZnhfcGVuZGluZ19nZXRfcGt0X3VzX2RlbGF5KHdkZXYsIHNrYikpOworCXdmeF90eF9m
aWxsX3JhdGVzKHdkZXYsIHR4X2luZm8sIGFyZyk7CisJLy8gRnJvbSBub3csIHlvdSBjYW4gdG91
Y2ggdG8gdHhfaW5mby0+c3RhdHVzLCBidXQgZG8gbm90IHRvdWNoIHRvCisJLy8gdHhfcHJpdiBh
bnltb3JlCisJLy8gRklYTUU6IHVzZSBpZWVlODAyMTFfdHhfaW5mb19jbGVhcl9zdGF0dXMoKQor
CW1lbXNldCh0eF9pbmZvLT5yYXRlX2RyaXZlcl9kYXRhLCAwLCBzaXplb2YodHhfaW5mby0+cmF0
ZV9kcml2ZXJfZGF0YSkpOworCW1lbXNldCh0eF9pbmZvLT5wYWQsIDAsIHNpemVvZih0eF9pbmZv
LT5wYWQpKTsKKworCWlmICghYXJnLT5zdGF0dXMpIHsKKwkJdHhfaW5mby0+c3RhdHVzLnR4X3Rp
bWUgPQorCQkJbGUzMl90b19jcHUoYXJnLT5tZWRpYV9kZWxheSkgLQorCQkJbGUzMl90b19jcHUo
YXJnLT50eF9xdWV1ZV9kZWxheSk7CisJCWlmICh0eF9pbmZvLT5mbGFncyAmIElFRUU4MDIxMV9U
WF9DVExfTk9fQUNLKQorCQkJdHhfaW5mby0+ZmxhZ3MgfD0gSUVFRTgwMjExX1RYX1NUQVRfTk9B
Q0tfVFJBTlNNSVRURUQ7CisJCWVsc2UKKwkJCXR4X2luZm8tPmZsYWdzIHw9IElFRUU4MDIxMV9U
WF9TVEFUX0FDSzsKKwl9IGVsc2UgaWYgKGFyZy0+c3RhdHVzID09IEhJRl9TVEFUVVNfVFhfRkFJ
TF9SRVFVRVVFKSB7CisJCVdBUk4oIWFyZy0+cmVxdWV1ZSwgImluY29oZXJlbnQgc3RhdHVzIGFu
ZCByZXN1bHRfZmxhZ3MiKTsKKwkJaWYgKHR4X2luZm8tPmZsYWdzICYgSUVFRTgwMjExX1RYX0NU
TF9TRU5EX0FGVEVSX0RUSU0pIHsKKwkJCXd2aWYtPmFmdGVyX2R0aW1fdHhfYWxsb3dlZCA9IGZh
bHNlOyAvLyBEVElNIHBlcmlvZCBlbGFwc2VkCisJCQlzY2hlZHVsZV93b3JrKCZ3dmlmLT51cGRh
dGVfdGltX3dvcmspOworCQl9CisJCXR4X2luZm8tPmZsYWdzIHw9IElFRUU4MDIxMV9UWF9TVEFU
X1RYX0ZJTFRFUkVEOworCX0KKwl3Znhfc2tiX2R0b3Iod3ZpZiwgc2tiKTsKK30KKworc3RhdGlj
IHZvaWQgd2Z4X2ZsdXNoX3ZpZihzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwgdTMyIHF1ZXVlcywKKwkJ
CSAgc3RydWN0IHNrX2J1ZmZfaGVhZCAqZHJvcHBlZCkKK3sKKwlzdHJ1Y3Qgd2Z4X3F1ZXVlICpx
dWV1ZTsKKwlpbnQgaTsKKworCWZvciAoaSA9IDA7IGkgPCBJRUVFODAyMTFfTlVNX0FDUzsgaSsr
KSB7CisJCWlmICghKEJJVChpKSAmIHF1ZXVlcykpCisJCQljb250aW51ZTsKKwkJcXVldWUgPSAm
d3ZpZi0+dHhfcXVldWVbaV07CisJCWlmIChkcm9wcGVkKQorCQkJd2Z4X3R4X3F1ZXVlX2Ryb3Ao
d3ZpZiwgcXVldWUsIGRyb3BwZWQpOworCX0KKwlpZiAod3ZpZi0+d2Rldi0+Y2hpcF9mcm96ZW4p
CisJCXJldHVybjsKKwlmb3IgKGkgPSAwOyBpIDwgSUVFRTgwMjExX05VTV9BQ1M7IGkrKykgewor
CQlpZiAoIShCSVQoaSkgJiBxdWV1ZXMpKQorCQkJY29udGludWU7CisJCXF1ZXVlID0gJnd2aWYt
PnR4X3F1ZXVlW2ldOworCQlpZiAod2FpdF9ldmVudF90aW1lb3V0KHd2aWYtPndkZXYtPnR4X2Rl
cXVldWUsCisJCQkJICAgICAgIHdmeF90eF9xdWV1ZV9lbXB0eSh3dmlmLCBxdWV1ZSksCisJCQkJ
ICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpIDw9IDApCisJCQlkZXZfd2Fybih3dmlmLT53
ZGV2LT5kZXYsCisJCQkJICJmcmFtZXMgcXVldWVkIHdoaWxlIGZsdXNoaW5nIHR4IHF1ZXVlcz8i
KTsKKwl9Cit9CisKK3ZvaWQgd2Z4X2ZsdXNoKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1
Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLAorCSAgICAgICB1MzIgcXVldWVzLCBib29sIGRyb3ApCit7
CisJc3RydWN0IHdmeF9kZXYgKndkZXYgPSBody0+cHJpdjsKKwlzdHJ1Y3Qgc2tfYnVmZl9oZWFk
IGRyb3BwZWQ7CisJc3RydWN0IHdmeF92aWYgKnd2aWY7CisJc3RydWN0IGhpZl9tc2cgKmhpZjsK
KwlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOworCisJc2tiX3F1ZXVlX2hlYWRfaW5pdCgmZHJvcHBlZCk7
CisJaWYgKHZpZikgeworCQl3dmlmID0gKHN0cnVjdCB3ZnhfdmlmICopdmlmLT5kcnZfcHJpdjsK
KwkJd2Z4X2ZsdXNoX3ZpZih3dmlmLCBxdWV1ZXMsIGRyb3AgPyAmZHJvcHBlZCA6IE5VTEwpOwor
CX0gZWxzZSB7CisJCXd2aWYgPSBOVUxMOworCQl3aGlsZSAoKHd2aWYgPSB3dmlmX2l0ZXJhdGUo
d2Rldiwgd3ZpZikpICE9IE5VTEwpCisJCQl3ZnhfZmx1c2hfdmlmKHd2aWYsIHF1ZXVlcywgZHJv
cCA/ICZkcm9wcGVkIDogTlVMTCk7CisJfQorCXdmeF90eF9mbHVzaCh3ZGV2KTsKKwlpZiAod2Rl
di0+Y2hpcF9mcm96ZW4pCisJCXdmeF9wZW5kaW5nX2Ryb3Aod2RldiwgJmRyb3BwZWQpOworCXdo
aWxlICgoc2tiID0gc2tiX2RlcXVldWUoJmRyb3BwZWQpKSAhPSBOVUxMKSB7CisJCWhpZiA9IChz
dHJ1Y3QgaGlmX21zZyAqKXNrYi0+ZGF0YTsKKwkJd3ZpZiA9IHdkZXZfdG9fd3ZpZih3ZGV2LCBo
aWYtPmludGVyZmFjZSk7CisJCWllZWU4MDIxMV90eF9pbmZvX2NsZWFyX3N0YXR1cyhJRUVFODAy
MTFfU0tCX0NCKHNrYikpOworCQl3Znhfc2tiX2R0b3Iod3ZpZiwgc2tiKTsKKwl9Cit9CmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHguaCBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0YV90eC5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAwMDAwMC4uNDZjOWZmZjdhODcwCi0tLSAvZGV2L251bGwKKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9kYXRhX3R4LmgKQEAgLTAsMCArMSw2NyBAQAor
LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLworLyoKKyAqIERhdGFw
YXRoIGltcGxlbWVudGF0aW9uLgorICoKKyAqIENvcHlyaWdodCAoYykgMjAxNy0yMDIwLCBTaWxp
Y29uIExhYm9yYXRvcmllcywgSW5jLgorICogQ29weXJpZ2h0IChjKSAyMDEwLCBTVC1Fcmljc3Nv
bgorICovCisjaWZuZGVmIFdGWF9EQVRBX1RYX0gKKyNkZWZpbmUgV0ZYX0RBVEFfVFhfSAorCisj
aW5jbHVkZSA8bGludXgvbGlzdC5oPgorI2luY2x1ZGUgPG5ldC9tYWM4MDIxMS5oPgorCisjaW5j
bHVkZSAiaGlmX2FwaV9jbWQuaCIKKyNpbmNsdWRlICJoaWZfYXBpX21pYi5oIgorCitzdHJ1Y3Qg
d2Z4X3R4X3ByaXY7CitzdHJ1Y3Qgd2Z4X2RldjsKK3N0cnVjdCB3ZnhfdmlmOworCitzdHJ1Y3Qg
dHhfcG9saWN5IHsKKwlzdHJ1Y3QgbGlzdF9oZWFkIGxpbms7CisJaW50IHVzYWdlX2NvdW50Owor
CXU4IHJhdGVzWzEyXTsKKwlib29sIHVwbG9hZGVkOworfTsKKworc3RydWN0IHR4X3BvbGljeV9j
YWNoZSB7CisJc3RydWN0IHR4X3BvbGljeSBjYWNoZVtISUZfVFhfUkVUUllfUE9MSUNZX01BWF07
CisJLy8gRklYTUU6IHVzZSBhIHRyZWVzIGFuZCBkcm9wIGhhc2ggZnJvbSB0eF9wb2xpY3kKKwlz
dHJ1Y3QgbGlzdF9oZWFkIHVzZWQ7CisJc3RydWN0IGxpc3RfaGVhZCBmcmVlOworCXNwaW5sb2Nr
X3QgbG9jazsKK307CisKK3N0cnVjdCB3ZnhfdHhfcHJpdiB7CisJa3RpbWVfdCB4bWl0X3RpbWVz
dGFtcDsKK307CisKK3ZvaWQgd2Z4X3R4X3BvbGljeV9pbml0KHN0cnVjdCB3ZnhfdmlmICp3dmlm
KTsKK3ZvaWQgd2Z4X3R4X3BvbGljeV91cGxvYWRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspOworCit2b2lkIHdmeF90eChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4
MDIxMV90eF9jb250cm9sICpjb250cm9sLAorCSAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKTsKK3Zv
aWQgd2Z4X3R4X2NvbmZpcm1fY2Ioc3RydWN0IHdmeF9kZXYgKndkZXYsIGNvbnN0IHN0cnVjdCBo
aWZfY25mX3R4ICphcmcpOwordm9pZCB3ZnhfZmx1c2goc3RydWN0IGllZWU4MDIxMV9odyAqaHcs
IHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsCisJICAgICAgIHUzMiBxdWV1ZXMsIGJvb2wgZHJv
cCk7CisKK3N0YXRpYyBpbmxpbmUgc3RydWN0IHdmeF90eF9wcml2ICp3Znhfc2tiX3R4X3ByaXYo
c3RydWN0IHNrX2J1ZmYgKnNrYikKK3sKKwlzdHJ1Y3QgaWVlZTgwMjExX3R4X2luZm8gKnR4X2lu
Zm87CisKKwlpZiAoIXNrYikKKwkJcmV0dXJuIE5VTEw7CisJdHhfaW5mbyA9IElFRUU4MDIxMV9T
S0JfQ0Ioc2tiKTsKKwlyZXR1cm4gKHN0cnVjdCB3ZnhfdHhfcHJpdiAqKXR4X2luZm8tPnJhdGVf
ZHJpdmVyX2RhdGE7Cit9CisKK3N0YXRpYyBpbmxpbmUgc3RydWN0IGhpZl9yZXFfdHggKndmeF9z
a2JfdHhyZXEoc3RydWN0IHNrX2J1ZmYgKnNrYikKK3sKKwlzdHJ1Y3QgaGlmX21zZyAqaGlmID0g
KHN0cnVjdCBoaWZfbXNnICopc2tiLT5kYXRhOworCXN0cnVjdCBoaWZfcmVxX3R4ICpyZXEgPSAo
c3RydWN0IGhpZl9yZXFfdHggKiloaWYtPmJvZHk7CisKKwlyZXR1cm4gcmVxOworfQorCisjZW5k
aWYgLyogV0ZYX0RBVEFfVFhfSCAqLwotLSAKMi4yOC4wCgo=
