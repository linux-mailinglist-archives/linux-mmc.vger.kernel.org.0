Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1522E1E94
	for <lists+linux-mmc@lfdr.de>; Wed, 23 Dec 2020 16:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgLWPmT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 23 Dec 2020 10:42:19 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:3743
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729384AbgLWPmQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 23 Dec 2020 10:42:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERDrkG2aDHs4T+22IXb17tEdH0FAOlhUlIEnSBQ/vveI6RzHODFTI3MGuhugeWfTW4U7CMETIAZmnc9xZAd+H7KuLLup593Ej6HRWPwq2abyAunZTUKjXEK7bSXxJvbRKcyqpuyoiRnh648bgK/HutjyH1QITuwgVOLfFab59EzGj/tOFMQSj3PYw7GMJQSvEL+/5TZY8kashQTwi0Oc9tmLsoP1MyMQlulgg7o61KiMzz0yAlg7wrQkZTADDdf+kZ9vKP20/4zU9uIWC0u3McnDrVN3GWFsr+dK0uOznj9xW3qjqLsjSjk6XLoiqBjeDnR+nZ6C3S4aPeFgfgg96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3y70wb4OswZ5As3falc/MhbbDLY1EEWwOF2pKXwviY=;
 b=KKQJn11rxRfVSt2gLMgZTPjMNNc3/HiyvmwhtJPTpcIkKsGPJiHAODJ+5r3t4fVbr1aejALqo7bVBxtcqKAbXcnAI0motCUwAFBI5dxW7vmQ6s88MT4dKBkVinuGEzpzBIUs/uZJJQ0HJRz4525qaUwlGcsWbG7KjK65OGM34IRpLa3qcqpYwzv+2kmsO9QeRjjDkWkRoy96BDIJ8YZ4aPS1LCnuC/OjKQu5Qx8zfc6J3hSR+aZQeyjOdRPlYmkrQWoetOBw3yCXMjPchiH1TkwsLAtVY54QJf/G3584CPqax1wccgn7YwjlWxXiOLqjibJadcvbyt3oJ2WqAAw9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3y70wb4OswZ5As3falc/MhbbDLY1EEWwOF2pKXwviY=;
 b=JNGLj7pK60LIWFsy3HkSzDWDFmtbp/x0TDUydtbI8y8xQ9snYU4WCH9np5Uoqv2dF1Cp03d3un0bcoaMHn6gOW/ZBOTx2/y/183OUqNSJ4t+aF18XuPMoDHfXyNDPIlLsWWX+RfTlEwvZrJd5BxngJzbzzCwX/XyrTNWdMdv/mY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB2815.namprd11.prod.outlook.com (2603:10b6:805:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Wed, 23 Dec
 2020 15:40:30 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::a989:f850:6736:97ca]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::a989:f850:6736:97ca%5]) with mapi id 15.20.3700.026; Wed, 23 Dec 2020
 15:40:30 +0000
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
Subject: [PATCH v4 21/24] wfx: add debug.c/debug.h
Date:   Wed, 23 Dec 2020 16:39:22 +0100
Message-Id: <20201223153925.73742-22-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223153925.73742-1-Jerome.Pouiller@silabs.com>
References: <20201223153925.73742-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Originating-IP: [82.67.86.106]
X-ClientProxiedBy: SA0PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:806:6f::29) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.silabs.com (82.67.86.106) by SA0PR12CA0024.namprd12.prod.outlook.com (2603:10b6:806:6f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Wed, 23 Dec 2020 15:40:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d852495f-8214-4ce6-730b-08d8a7591435
X-MS-TrafficTypeDiagnostic: SN6PR11MB2815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB28157BEE02419BFB8E60582493DE0@SN6PR11MB2815.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aa6boP7yaAmsaN0wBMryhjhXBd0xU88iIokYv0SVEhNR6Tr/RcTVQ6ERfsjggIcNl95hRgTKazY3EIShoGWUCCn8DdMbdpMy8+5+ikd5bHYs4OnY7wAa8POkxzkbmfaOWKVHs2nbt8zCgVBtREkQgVLbD+W/iwc6L5MbSI9ANDcOCoDSW8HquXAwQnRx6rdeiiWLT/iRz3cqfZ/TAWHrVFaXeY0xc8E2/YZcdawm+uQuOH/P58n273T3Y7He7hP2JHuYyVbQY2MDQOatzMz5ivr2MMHAubfQOp1yBxXyHRhU+wo+dDaTaUPbl1dxrgPGqM+dea4KGZq4GKC4nPBbw9StG940tscuoEeQu6reElPv/rlK8b4fSBt/2ritB412UwCzikMXQEYhB2qHINRutQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(39850400004)(346002)(66574015)(478600001)(83380400001)(8676002)(186003)(2906002)(8936002)(26005)(52116002)(107886003)(16526019)(7696005)(66946007)(7416002)(6486002)(956004)(2616005)(54906003)(66476007)(316002)(4326008)(6666004)(36756003)(5660300002)(1076003)(86362001)(66556008)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?akdBZzkvWFRaNlA5SlRYdDc2cHgrc3YveXdaeEdJZUNkM2VjS2t6cTh1dElD?=
 =?utf-8?B?elZWdzVkSTdaTXBEQnJtbTVLNUVEMTdtZUpWbmdVUVhkTW5WWXorYy9oS1lU?=
 =?utf-8?B?R1U4SHdiVXFlTHNqUnBzUDRyaStLSVJNeFA4Q0l6TTBUNkpIRGxpL2lmcml6?=
 =?utf-8?B?Z2NEdTViUitDNytZSHU3Y25VdjB6ZnJZejJLSnNOSmczdmpqS1RIU2Y5Qmor?=
 =?utf-8?B?dmh6Rzl5SCtYK3VmOEhUYnBhWndKN25peDYvSlNEV2ljaHY1NktrYXg4cUxR?=
 =?utf-8?B?d2xVcmExclM0ZkJxYXFGY2RpYnZyVEtjeElrR3NxWUlnMUI3dFVtV3lzYnFY?=
 =?utf-8?B?VUk0czExQ2lCVVA2WEkrVFlkWWpSaldnNG15MGJzK2Nkb0lyaGxtMnpmcVBy?=
 =?utf-8?B?RVBrcWNYRGVrUk91NUlVYjhWaW9MaXBHMGVUczVtb01GRmZKMldLWmhkT1g5?=
 =?utf-8?B?SG91Z29jb1NMS3ZTWFByemQ5aGppOVRXSTVUaFBMMG41R0ttZXVGajhVdWU1?=
 =?utf-8?B?TXN2S2lWQlZZelc1c2FOazVWcUhLbUpIVE5ZTkZIWGYxRmNDRHIzSkxGaE1X?=
 =?utf-8?B?NnRNOGNMNTlONUJyNWJEdVIxREs5UW1QRDZ6NFNNUlhVNWNnME55V3RabFBX?=
 =?utf-8?B?blRGbkxMclN5djA2bXAwbHdqcHZVZFcxNWpoQmtBUlFWOExpYlFnQVJicEUz?=
 =?utf-8?B?QkpIZTk1NU5rYTZZM1Zzc0loekZlWjRyb0NVUDI2UUxmaGFrSExXTFZLS0FI?=
 =?utf-8?B?ekI0SlBMRklsbmhqdlM4Q1R6Mkdzc0RTUFh3STJoUUlMRCt0SVRldUFzd2pi?=
 =?utf-8?B?dDJQMkFEVVNpL25Edy9ldHY1ZTQva3cwVFQzQWFXdnBTTE1ZSCt3MWJLR29p?=
 =?utf-8?B?b01UdWNreWwvbnJHQzVzVUVyc0lKOEJnMVF3T0RvelRYWWVFS2Zmc25GRlpw?=
 =?utf-8?B?dUIrVmY2aCtKN3Y0ODZZV3B2TU43UGdpUEQ5eXJXU1VQeGloSzZQOHArNFpU?=
 =?utf-8?B?R2hFYmxWWHI5V3ArWEx6Wk1lMTVnbENXSmdvNnZzU0FGdXRoV0VjVXFoekJq?=
 =?utf-8?B?bkRhWEk1STV1ZGx0b2xRYlcrQk93aFM4ZDYvRVVrQ0svdkpvQmFEcGZtU1A4?=
 =?utf-8?B?SWc5Q2VvZ2NvSEc1eXlrRTRSTGZ0Si9obXZoZGhiditGcFZDRjRiaDZHZHVn?=
 =?utf-8?B?RnJYZGs4SngxNHhhblN2aUl5YzN0cnRmRjNIVTY1WW16WlRZaEZaUnVjclN3?=
 =?utf-8?B?SldCUlJ3QlAySk9JcE5QQlh4QXNEMnRWYmdKL2JvL3oxVk5UNkpnYW9jWkRD?=
 =?utf-8?Q?8KeVz2TaWjwN8I9ZQAe2sWNt85BQ66m4aF?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2020 15:40:30.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-Network-Message-Id: d852495f-8214-4ce6-730b-08d8a7591435
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcXbFllEVrEXZlM3ilEKdXOb6wk3wmkTCq0QBYmILQy86bRiAjP0Rfoay6vRPCGprohs1GcWWRkBSpMGen+P2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2815
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYyB8IDM2MSArKysr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVi
dWcuaCB8ICAxOSArKwogMiBmaWxlcyBjaGFuZ2VkLCAzODAgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYwogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuaAoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYwpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMDAuLjNmNzEwMTIxM2RmMwotLS0gL2Rldi9udWxsCisrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYwpAQCAtMCwwICsxLDM2MSBAQAor
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQorLyoKKyAqIERlYnVnZnMg
aW50ZXJmYWNlLgorICoKKyAqIENvcHlyaWdodCAoYykgMjAxNy0yMDIwLCBTaWxpY29uIExhYm9y
YXRvcmllcywgSW5jLgorICogQ29weXJpZ2h0IChjKSAyMDEwLCBTVC1Fcmljc3NvbgorICovCisj
aW5jbHVkZSA8bGludXgvZGVidWdmcy5oPgorI2luY2x1ZGUgPGxpbnV4L3NlcV9maWxlLmg+Cisj
aW5jbHVkZSA8bGludXgvY3JjMzIuaD4KKworI2luY2x1ZGUgImRlYnVnLmgiCisjaW5jbHVkZSAi
d2Z4LmgiCisjaW5jbHVkZSAic3RhLmgiCisjaW5jbHVkZSAibWFpbi5oIgorI2luY2x1ZGUgImhp
Zl90eC5oIgorI2luY2x1ZGUgImhpZl90eF9taWIuaCIKKworI2RlZmluZSBDUkVBVEVfVFJBQ0Vf
UE9JTlRTCisjaW5jbHVkZSAidHJhY2VzLmgiCisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgdHJhY2Vf
cHJpbnRfZmxhZ3MgaGlmX21zZ19wcmludF9tYXBbXSA9IHsKKwloaWZfbXNnX2xpc3QsCit9Owor
CitzdGF0aWMgY29uc3Qgc3RydWN0IHRyYWNlX3ByaW50X2ZsYWdzIGhpZl9taWJfcHJpbnRfbWFw
W10gPSB7CisJaGlmX21pYl9saXN0LAorfTsKKworc3RhdGljIGNvbnN0IHN0cnVjdCB0cmFjZV9w
cmludF9mbGFncyB3ZnhfcmVnX3ByaW50X21hcFtdID0geworCXdmeF9yZWdfbGlzdCwKK307CisK
K3N0YXRpYyBjb25zdCBjaGFyICpnZXRfc3ltYm9sKHVuc2lnbmVkIGxvbmcgdmFsLAorCQkJICAg
ICAgY29uc3Qgc3RydWN0IHRyYWNlX3ByaW50X2ZsYWdzICpzeW1ib2xfYXJyYXkpCit7CisJaW50
IGk7CisKKwlmb3IgKGkgPSAwOyBzeW1ib2xfYXJyYXlbaV0ubWFzayAhPSAtMTsgaSsrKSB7CisJ
CWlmICh2YWwgPT0gc3ltYm9sX2FycmF5W2ldLm1hc2spCisJCQlyZXR1cm4gc3ltYm9sX2FycmF5
W2ldLm5hbWU7CisJfQorCisJcmV0dXJuICJ1bmtub3duIjsKK30KKworY29uc3QgY2hhciAqZ2V0
X2hpZl9uYW1lKHVuc2lnbmVkIGxvbmcgaWQpCit7CisJcmV0dXJuIGdldF9zeW1ib2woaWQsIGhp
Zl9tc2dfcHJpbnRfbWFwKTsKK30KKworY29uc3QgY2hhciAqZ2V0X21pYl9uYW1lKHVuc2lnbmVk
IGxvbmcgaWQpCit7CisJcmV0dXJuIGdldF9zeW1ib2woaWQsIGhpZl9taWJfcHJpbnRfbWFwKTsK
K30KKworY29uc3QgY2hhciAqZ2V0X3JlZ19uYW1lKHVuc2lnbmVkIGxvbmcgaWQpCit7CisJcmV0
dXJuIGdldF9zeW1ib2woaWQsIHdmeF9yZWdfcHJpbnRfbWFwKTsKK30KKworc3RhdGljIGludCB3
ZnhfY291bnRlcnNfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9pZCAqdikKK3sKKwlpbnQg
cmV0LCBpOworCXN0cnVjdCB3ZnhfZGV2ICp3ZGV2ID0gc2VxLT5wcml2YXRlOworCXN0cnVjdCBo
aWZfbWliX2V4dGVuZGVkX2NvdW50X3RhYmxlIGNvdW50ZXJzWzNdOworCisJZm9yIChpID0gMDsg
aSA8IEFSUkFZX1NJWkUoY291bnRlcnMpOyBpKyspIHsKKwkJcmV0ID0gaGlmX2dldF9jb3VudGVy
c190YWJsZSh3ZGV2LCBpLCBjb3VudGVycyArIGkpOworCQlpZiAocmV0IDwgMCkKKwkJCXJldHVy
biByZXQ7CisJCWlmIChyZXQgPiAwKQorCQkJcmV0dXJuIC1FSU87CisJfQorCisJc2VxX3ByaW50
ZihzZXEsICIlLTI0cyAlMTJzICUxMnMgJTEyc1xuIiwKKwkJICAgIiIsICJnbG9iYWwiLCAiaWZh
Y2UgMCIsICJpZmFjZSAxIik7CisKKyNkZWZpbmUgUFVUX0NPVU5URVIobmFtZSkgXAorCXNlcV9w
cmludGYoc2VxLCAiJS0yNHMgJTEyZCAlMTJkICUxMmRcbiIsICNuYW1lLCBcCisJCSAgIGxlMzJf
dG9fY3B1KGNvdW50ZXJzWzJdLmNvdW50XyMjbmFtZSksIFwKKwkJICAgbGUzMl90b19jcHUoY291
bnRlcnNbMF0uY291bnRfIyNuYW1lKSwgXAorCQkgICBsZTMyX3RvX2NwdShjb3VudGVyc1sxXS5j
b3VudF8jI25hbWUpKQorCisJUFVUX0NPVU5URVIodHhfcGFja2V0cyk7CisJUFVUX0NPVU5URVIo
dHhfbXVsdGljYXN0X2ZyYW1lcyk7CisJUFVUX0NPVU5URVIodHhfZnJhbWVzX3N1Y2Nlc3MpOwor
CVBVVF9DT1VOVEVSKHR4X2ZyYW1lX2ZhaWx1cmVzKTsKKwlQVVRfQ09VTlRFUih0eF9mcmFtZXNf
cmV0cmllZCk7CisJUFVUX0NPVU5URVIodHhfZnJhbWVzX211bHRpX3JldHJpZWQpOworCisJUFVU
X0NPVU5URVIocnRzX3N1Y2Nlc3MpOworCVBVVF9DT1VOVEVSKHJ0c19mYWlsdXJlcyk7CisJUFVU
X0NPVU5URVIoYWNrX2ZhaWx1cmVzKTsKKworCVBVVF9DT1VOVEVSKHJ4X3BhY2tldHMpOworCVBV
VF9DT1VOVEVSKHJ4X2ZyYW1lc19zdWNjZXNzKTsKKwlQVVRfQ09VTlRFUihyeF9wYWNrZXRfZXJy
b3JzKTsKKwlQVVRfQ09VTlRFUihwbGNwX2Vycm9ycyk7CisJUFVUX0NPVU5URVIoZmNzX2Vycm9y
cyk7CisJUFVUX0NPVU5URVIocnhfZGVjcnlwdGlvbl9mYWlsdXJlcyk7CisJUFVUX0NPVU5URVIo
cnhfbWljX2ZhaWx1cmVzKTsKKwlQVVRfQ09VTlRFUihyeF9ub19rZXlfZmFpbHVyZXMpOworCVBV
VF9DT1VOVEVSKHJ4X2ZyYW1lX2R1cGxpY2F0ZXMpOworCVBVVF9DT1VOVEVSKHJ4X211bHRpY2Fz
dF9mcmFtZXMpOworCVBVVF9DT1VOVEVSKHJ4X2NtYWNpY3ZfZXJyb3JzKTsKKwlQVVRfQ09VTlRF
UihyeF9jbWFjX3JlcGxheXMpOworCVBVVF9DT1VOVEVSKHJ4X21nbXRfY2NtcF9yZXBsYXlzKTsK
KworCVBVVF9DT1VOVEVSKHJ4X2JlYWNvbik7CisJUFVUX0NPVU5URVIobWlzc19iZWFjb24pOwor
CisjdW5kZWYgUFVUX0NPVU5URVIKKworCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGNvdW50
ZXJzWzBdLnJlc2VydmVkKTsgaSsrKQorCQlzZXFfcHJpbnRmKHNlcSwgInJlc2VydmVkWyUwMmRd
JTEycyAlMTJkICUxMmQgJTEyZFxuIiwgaSwgIiIsCisJCQkgICBsZTMyX3RvX2NwdShjb3VudGVy
c1syXS5yZXNlcnZlZFtpXSksCisJCQkgICBsZTMyX3RvX2NwdShjb3VudGVyc1swXS5yZXNlcnZl
ZFtpXSksCisJCQkgICBsZTMyX3RvX2NwdShjb3VudGVyc1sxXS5yZXNlcnZlZFtpXSkpOworCisJ
cmV0dXJuIDA7Cit9CitERUZJTkVfU0hPV19BVFRSSUJVVEUod2Z4X2NvdW50ZXJzKTsKKworc3Rh
dGljIGNvbnN0IGNoYXIgKiBjb25zdCBjaGFubmVsX25hbWVzW10gPSB7CisJWzBdID0gIjFNIiwK
KwlbMV0gPSAiMk0iLAorCVsyXSA9ICI1LjVNIiwKKwlbM10gPSAiMTFNIiwKKwkvKiBFbnRyaWVz
IDQgYW5kIDUgZG9lcyBub3QgZXhpc3QgKi8KKwlbNl0gPSAiNk0iLAorCVs3XSA9ICI5TSIsCisJ
WzhdID0gIjEyTSIsCisJWzldID0gIjE4TSIsCisJWzEwXSA9ICIyNE0iLAorCVsxMV0gPSAiMzZN
IiwKKwlbMTJdID0gIjQ4TSIsCisJWzEzXSA9ICI1NE0iLAorCVsxNF0gPSAiTUNTMCIsCisJWzE1
XSA9ICJNQ1MxIiwKKwlbMTZdID0gIk1DUzIiLAorCVsxN10gPSAiTUNTMyIsCisJWzE4XSA9ICJN
Q1M0IiwKKwlbMTldID0gIk1DUzUiLAorCVsyMF0gPSAiTUNTNiIsCisJWzIxXSA9ICJNQ1M3IiwK
K307CisKK3N0YXRpYyBpbnQgd2Z4X3J4X3N0YXRzX3Nob3coc3RydWN0IHNlcV9maWxlICpzZXEs
IHZvaWQgKnYpCit7CisJc3RydWN0IHdmeF9kZXYgKndkZXYgPSBzZXEtPnByaXZhdGU7CisJc3Ry
dWN0IGhpZl9yeF9zdGF0cyAqc3QgPSAmd2Rldi0+cnhfc3RhdHM7CisJaW50IGk7CisKKwltdXRl
eF9sb2NrKCZ3ZGV2LT5yeF9zdGF0c19sb2NrKTsKKwlzZXFfcHJpbnRmKHNlcSwgIlRpbWVzdGFt
cDogJWR1c1xuIiwgc3QtPmRhdGUpOworCXNlcV9wcmludGYoc2VxLCAiTG93IHBvd2VyIGNsb2Nr
OiBmcmVxdWVuY3kgJXVIeiwgZXh0ZXJuYWwgJXNcbiIsCisJCSAgIGxlMzJfdG9fY3B1KHN0LT5w
d3JfY2xrX2ZyZXEpLAorCQkgICBzdC0+aXNfZXh0X3B3cl9jbGsgPyAieWVzIiA6ICJubyIpOwor
CXNlcV9wcmludGYoc2VxLAorCQkgICAiTnVtLiBvZiBmcmFtZXM6ICVkLCBQRVIgKHgxMGU0KTog
JWQsIFRocm91Z2hwdXQ6ICVkS2Jwcy9zXG4iLAorCQkgICBzdC0+bmJfcnhfZnJhbWUsIHN0LT5w
ZXJfdG90YWwsIHN0LT50aHJvdWdocHV0KTsKKwlzZXFfcHV0cyhzZXEsICIgICAgICAgTnVtLiBv
ZiAgICAgIFBFUiAgICAgUlNTSSAgICAgIFNOUiAgICAgIENGT1xuIik7CisJc2VxX3B1dHMoc2Vx
LCAiICAgICAgICBmcmFtZXMgICh4MTBlNCkgICAgKGRCbSkgICAgIChkQikgICAgKGtIeilcbiIp
OworCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGNoYW5uZWxfbmFtZXMpOyBpKyspIHsKKwkJ
aWYgKGNoYW5uZWxfbmFtZXNbaV0pCisJCQlzZXFfcHJpbnRmKHNlcSwgIiU1cyAlOGQgJThkICU4
ZCAlOGQgJThkXG4iLAorCQkJCSAgIGNoYW5uZWxfbmFtZXNbaV0sCisJCQkJICAgbGUzMl90b19j
cHUoc3QtPm5iX3J4X2J5X3JhdGVbaV0pLAorCQkJCSAgIGxlMTZfdG9fY3B1KHN0LT5wZXJbaV0p
LAorCQkJCSAgIChzMTYpbGUxNl90b19jcHUoc3QtPnJzc2lbaV0pIC8gMTAwLAorCQkJCSAgIChz
MTYpbGUxNl90b19jcHUoc3QtPnNucltpXSkgLyAxMDAsCisJCQkJICAgKHMxNilsZTE2X3RvX2Nw
dShzdC0+Y2ZvW2ldKSk7CisJfQorCW11dGV4X3VubG9jaygmd2Rldi0+cnhfc3RhdHNfbG9jayk7
CisKKwlyZXR1cm4gMDsKK30KK0RFRklORV9TSE9XX0FUVFJJQlVURSh3Znhfcnhfc3RhdHMpOwor
CitzdGF0aWMgaW50IHdmeF90eF9wb3dlcl9sb29wX3Nob3coc3RydWN0IHNlcV9maWxlICpzZXEs
IHZvaWQgKnYpCit7CisJc3RydWN0IHdmeF9kZXYgKndkZXYgPSBzZXEtPnByaXZhdGU7CisJc3Ry
dWN0IGhpZl90eF9wb3dlcl9sb29wX2luZm8gKnN0ID0gJndkZXYtPnR4X3Bvd2VyX2xvb3BfaW5m
bzsKKwlpbnQgdG1wOworCisJbXV0ZXhfbG9jaygmd2Rldi0+dHhfcG93ZXJfbG9vcF9pbmZvX2xv
Y2spOworCXRtcCA9IGxlMTZfdG9fY3B1KHN0LT50eF9nYWluX2RpZyk7CisJc2VxX3ByaW50Zihz
ZXEsICJUeCBnYWluIGRpZ2l0YWw6ICVkXG4iLCB0bXApOworCXRtcCA9IGxlMTZfdG9fY3B1KHN0
LT50eF9nYWluX3BhKTsKKwlzZXFfcHJpbnRmKHNlcSwgIlR4IGdhaW4gUEE6ICVkXG4iLCB0bXAp
OworCXRtcCA9IChzMTYpbGUxNl90b19jcHUoc3QtPnRhcmdldF9wb3V0KTsKKwlzZXFfcHJpbnRm
KHNlcSwgIlRhcmdldCBQb3V0OiAlZC4lMDJkIGRCbVxuIiwgdG1wIC8gNCwgKHRtcCAlIDQpICog
MjUpOworCXRtcCA9IChzMTYpbGUxNl90b19jcHUoc3QtPnBfZXN0aW1hdGlvbik7CisJc2VxX3By
aW50ZihzZXEsICJGRU0gUG91dDogJWQuJTAyZCBkQm1cbiIsIHRtcCAvIDQsICh0bXAgJSA0KSAq
IDI1KTsKKwl0bXAgPSBsZTE2X3RvX2NwdShzdC0+dnBkZXQpOworCXNlcV9wcmludGYoc2VxLCAi
VnBkZXQ6ICVkIG1WXG4iLCB0bXApOworCXNlcV9wcmludGYoc2VxLCAiTWVhc3VyZSBpbmRleDog
JWRcbiIsIHN0LT5tZWFzdXJlbWVudF9pbmRleCk7CisJbXV0ZXhfdW5sb2NrKCZ3ZGV2LT50eF9w
b3dlcl9sb29wX2luZm9fbG9jayk7CisKKwlyZXR1cm4gMDsKK30KK0RFRklORV9TSE9XX0FUVFJJ
QlVURSh3ZnhfdHhfcG93ZXJfbG9vcCk7CisKK3N0YXRpYyBzc2l6ZV90IHdmeF9zZW5kX3Bkc193
cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKKwkJCQkgIGNvbnN0IGNoYXIgX191c2VyICp1c2VyX2J1
ZiwKKwkJCQkgIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQoreworCXN0cnVjdCB3ZnhfZGV2
ICp3ZGV2ID0gZmlsZS0+cHJpdmF0ZV9kYXRhOworCWNoYXIgKmJ1ZjsKKwlpbnQgcmV0OworCisJ
aWYgKCpwcG9zICE9IDApIHsKKwkJZGV2X2RiZyh3ZGV2LT5kZXYsICJQRFMgZGF0YSBtdXN0IGJl
IHdyaXR0ZW4gaW4gb25lIHRyYW5zYWN0aW9uIik7CisJCXJldHVybiAtRUJVU1k7CisJfQorCWJ1
ZiA9IG1lbWR1cF91c2VyKHVzZXJfYnVmLCBjb3VudCk7CisJaWYgKElTX0VSUihidWYpKQorCQly
ZXR1cm4gUFRSX0VSUihidWYpOworCSpwcG9zID0gKnBwb3MgKyBjb3VudDsKKwlyZXQgPSB3Znhf
c2VuZF9wZHMod2RldiwgYnVmLCBjb3VudCk7CisJa2ZyZWUoYnVmKTsKKwlpZiAocmV0IDwgMCkK
KwkJcmV0dXJuIHJldDsKKwlyZXR1cm4gY291bnQ7Cit9CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZmlsZV9vcGVyYXRpb25zIHdmeF9zZW5kX3Bkc19mb3BzID0geworCS5vcGVuID0gc2ltcGxlX29w
ZW4sCisJLndyaXRlID0gd2Z4X3NlbmRfcGRzX3dyaXRlLAorfTsKKworc3RydWN0IGRiZ2ZzX2hp
Zl9tc2cgeworCXN0cnVjdCB3ZnhfZGV2ICp3ZGV2OworCXN0cnVjdCBjb21wbGV0aW9uIGNvbXBs
ZXRlOworCXU4IHJlcGx5WzEwMjRdOworCWludCByZXQ7Cit9OworCitzdGF0aWMgc3NpemVfdCB3
Znhfc2VuZF9oaWZfbXNnX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAorCQkJCSAgICAgIGNvbnN0
IGNoYXIgX191c2VyICp1c2VyX2J1ZiwKKwkJCQkgICAgICBzaXplX3QgY291bnQsIGxvZmZfdCAq
cHBvcykKK3sKKwlzdHJ1Y3QgZGJnZnNfaGlmX21zZyAqY29udGV4dCA9IGZpbGUtPnByaXZhdGVf
ZGF0YTsKKwlzdHJ1Y3Qgd2Z4X2RldiAqd2RldiA9IGNvbnRleHQtPndkZXY7CisJc3RydWN0IGhp
Zl9tc2cgKnJlcXVlc3Q7CisKKwlpZiAoY29tcGxldGlvbl9kb25lKCZjb250ZXh0LT5jb21wbGV0
ZSkpIHsKKwkJZGV2X2RiZyh3ZGV2LT5kZXYsICJyZWFkIHByZXZpb3VzIHJlc3VsdCBiZWZvcmUg
c3RhcnQgYSBuZXcgb25lXG4iKTsKKwkJcmV0dXJuIC1FQlVTWTsKKwl9CisJaWYgKGNvdW50IDwg
c2l6ZW9mKHN0cnVjdCBoaWZfbXNnKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwkvKiB3ZnhfY21k
X3NlbmQoKSBjaGVja3MgdGhhdCByZXBseSBidWZmZXIgaXMgd2lkZSBlbm91Z2gsIGJ1dCBkb2Vz
IG5vdAorCSAqIHJldHVybiBwcmVjaXNlIGxlbmd0aCByZWFkLiBVc2VyIGhhdmUgdG8ga25vdyBo
b3cgbWFueSBieXRlcyBzaG91bGQKKwkgKiBiZSByZWFkLiBGaWxsaW5nIHJlcGx5IGJ1ZmZlciB3
aXRoIGEgbWVtb3J5IHBhdHRlcm4gbWF5IGhlbHAgdXNlci4KKwkgKi8KKwltZW1zZXQoY29udGV4
dC0+cmVwbHksIDB4RkYsIHNpemVvZihjb250ZXh0LT5yZXBseSkpOworCXJlcXVlc3QgPSBtZW1k
dXBfdXNlcih1c2VyX2J1ZiwgY291bnQpOworCWlmIChJU19FUlIocmVxdWVzdCkpCisJCXJldHVy
biBQVFJfRVJSKHJlcXVlc3QpOworCWlmIChsZTE2X3RvX2NwdShyZXF1ZXN0LT5sZW4pICE9IGNv
dW50KSB7CisJCWtmcmVlKHJlcXVlc3QpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisJY29udGV4
dC0+cmV0ID0gd2Z4X2NtZF9zZW5kKHdkZXYsIHJlcXVlc3QsIGNvbnRleHQtPnJlcGx5LAorCQkJ
CSAgICBzaXplb2YoY29udGV4dC0+cmVwbHkpLCBmYWxzZSk7CisKKwlrZnJlZShyZXF1ZXN0KTsK
Kwljb21wbGV0ZSgmY29udGV4dC0+Y29tcGxldGUpOworCXJldHVybiBjb3VudDsKK30KKworc3Rh
dGljIHNzaXplX3Qgd2Z4X3NlbmRfaGlmX21zZ19yZWFkKHN0cnVjdCBmaWxlICpmaWxlLCBjaGFy
IF9fdXNlciAqdXNlcl9idWYsCisJCQkJICAgICBzaXplX3QgY291bnQsIGxvZmZfdCAqcHBvcykK
K3sKKwlzdHJ1Y3QgZGJnZnNfaGlmX21zZyAqY29udGV4dCA9IGZpbGUtPnByaXZhdGVfZGF0YTsK
KwlpbnQgcmV0OworCisJaWYgKGNvdW50ID4gc2l6ZW9mKGNvbnRleHQtPnJlcGx5KSkKKwkJcmV0
dXJuIC1FSU5WQUw7CisJcmV0ID0gd2FpdF9mb3JfY29tcGxldGlvbl9pbnRlcnJ1cHRpYmxlKCZj
b250ZXh0LT5jb21wbGV0ZSk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKwlpZiAoY29udGV4
dC0+cmV0IDwgMCkKKwkJcmV0dXJuIGNvbnRleHQtPnJldDsKKwkvKiBCZSBjYXJlZnVsLCB3cml0
ZSgpIGlzIHdhaXRpbmcgZm9yIGEgZnVsbCBtZXNzYWdlIHdoaWxlIHJlYWQoKQorCSAqIG9ubHkg
cmV0dXJucyBhIHBheWxvYWQKKwkgKi8KKwlpZiAoY29weV90b191c2VyKHVzZXJfYnVmLCBjb250
ZXh0LT5yZXBseSwgY291bnQpKQorCQlyZXR1cm4gLUVGQVVMVDsKKworCXJldHVybiBjb3VudDsK
K30KKworc3RhdGljIGludCB3Znhfc2VuZF9oaWZfbXNnX29wZW4oc3RydWN0IGlub2RlICppbm9k
ZSwgc3RydWN0IGZpbGUgKmZpbGUpCit7CisJc3RydWN0IGRiZ2ZzX2hpZl9tc2cgKmNvbnRleHQg
PSBremFsbG9jKHNpemVvZigqY29udGV4dCksIEdGUF9LRVJORUwpOworCisJaWYgKCFjb250ZXh0
KQorCQlyZXR1cm4gLUVOT01FTTsKKwljb250ZXh0LT53ZGV2ID0gaW5vZGUtPmlfcHJpdmF0ZTsK
Kwlpbml0X2NvbXBsZXRpb24oJmNvbnRleHQtPmNvbXBsZXRlKTsKKwlmaWxlLT5wcml2YXRlX2Rh
dGEgPSBjb250ZXh0OworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHdmeF9zZW5kX2hpZl9t
c2dfcmVsZWFzZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKK3sKKwlz
dHJ1Y3QgZGJnZnNfaGlmX21zZyAqY29udGV4dCA9IGZpbGUtPnByaXZhdGVfZGF0YTsKKworCWtm
cmVlKGNvbnRleHQpOworCXJldHVybiAwOworfQorCitzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVf
b3BlcmF0aW9ucyB3Znhfc2VuZF9oaWZfbXNnX2ZvcHMgPSB7CisJLm9wZW4gPSB3Znhfc2VuZF9o
aWZfbXNnX29wZW4sCisJLnJlbGVhc2UgPSB3Znhfc2VuZF9oaWZfbXNnX3JlbGVhc2UsCisJLndy
aXRlID0gd2Z4X3NlbmRfaGlmX21zZ193cml0ZSwKKwkucmVhZCA9IHdmeF9zZW5kX2hpZl9tc2df
cmVhZCwKK307CisKK3N0YXRpYyBpbnQgd2Z4X3BzX3RpbWVvdXRfc2V0KHZvaWQgKmRhdGEsIHU2
NCB2YWwpCit7CisJc3RydWN0IHdmeF9kZXYgKndkZXYgPSAoc3RydWN0IHdmeF9kZXYgKilkYXRh
OworCXN0cnVjdCB3ZnhfdmlmICp3dmlmOworCisJd2Rldi0+Zm9yY2VfcHNfdGltZW91dCA9IHZh
bDsKKwl3dmlmID0gTlVMTDsKKwl3aGlsZSAoKHd2aWYgPSB3dmlmX2l0ZXJhdGUod2Rldiwgd3Zp
ZikpICE9IE5VTEwpCisJCXdmeF91cGRhdGVfcG0od3ZpZik7CisJcmV0dXJuIDA7Cit9CisKK3N0
YXRpYyBpbnQgd2Z4X3BzX3RpbWVvdXRfZ2V0KHZvaWQgKmRhdGEsIHU2NCAqdmFsKQoreworCXN0
cnVjdCB3ZnhfZGV2ICp3ZGV2ID0gKHN0cnVjdCB3ZnhfZGV2ICopZGF0YTsKKworCSp2YWwgPSB3
ZGV2LT5mb3JjZV9wc190aW1lb3V0OworCXJldHVybiAwOworfQorCitERUZJTkVfREVCVUdGU19B
VFRSSUJVVEUod2Z4X3BzX3RpbWVvdXRfZm9wcywgd2Z4X3BzX3RpbWVvdXRfZ2V0LCB3ZnhfcHNf
dGltZW91dF9zZXQsICIlbGxkXG4iKTsKKworaW50IHdmeF9kZWJ1Z19pbml0KHN0cnVjdCB3Znhf
ZGV2ICp3ZGV2KQoreworCXN0cnVjdCBkZW50cnkgKmQ7CisKKwlkID0gZGVidWdmc19jcmVhdGVf
ZGlyKCJ3ZngiLCB3ZGV2LT5ody0+d2lwaHktPmRlYnVnZnNkaXIpOworCWRlYnVnZnNfY3JlYXRl
X2ZpbGUoImNvdW50ZXJzIiwgMDQ0NCwgZCwgd2RldiwgJndmeF9jb3VudGVyc19mb3BzKTsKKwlk
ZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJyeF9zdGF0cyIsIDA0NDQsIGQsIHdkZXYsICZ3Znhfcnhfc3Rh
dHNfZm9wcyk7CisJZGVidWdmc19jcmVhdGVfZmlsZSgidHhfcG93ZXJfbG9vcCIsIDA0NDQsIGQs
IHdkZXYsCisJCQkgICAgJndmeF90eF9wb3dlcl9sb29wX2ZvcHMpOworCWRlYnVnZnNfY3JlYXRl
X2ZpbGUoInNlbmRfcGRzIiwgMDIwMCwgZCwgd2RldiwgJndmeF9zZW5kX3Bkc19mb3BzKTsKKwlk
ZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJzZW5kX2hpZl9tc2ciLCAwNjAwLCBkLCB3ZGV2LAorCQkJICAg
ICZ3Znhfc2VuZF9oaWZfbXNnX2ZvcHMpOworCWRlYnVnZnNfY3JlYXRlX2ZpbGUoInBzX3RpbWVv
dXQiLCAwNjAwLCBkLCB3ZGV2LCAmd2Z4X3BzX3RpbWVvdXRfZm9wcyk7CisKKwlyZXR1cm4gMDsK
K30KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuaCBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuaApuZXcgZmlsZSBtb2RlIDEw
MDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjRiOWM0OWE5ZmZmYgotLS0gL2Rldi9udWxsCisrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuaApAQCAtMCwwICsxLDE5IEBA
CisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovCisvKgorICogRGVi
dWdmcyBpbnRlcmZhY2UuCisgKgorICogQ29weXJpZ2h0IChjKSAyMDE3LTIwMTksIFNpbGljb24g
TGFib3JhdG9yaWVzLCBJbmMuCisgKiBDb3B5cmlnaHQgKGMpIDIwMTEsIFNULUVyaWNzc29uCisg
Ki8KKyNpZm5kZWYgV0ZYX0RFQlVHX0gKKyNkZWZpbmUgV0ZYX0RFQlVHX0gKKworc3RydWN0IHdm
eF9kZXY7CisKK2ludCB3ZnhfZGVidWdfaW5pdChzdHJ1Y3Qgd2Z4X2RldiAqd2Rldik7CisKK2Nv
bnN0IGNoYXIgKmdldF9oaWZfbmFtZSh1bnNpZ25lZCBsb25nIGlkKTsKK2NvbnN0IGNoYXIgKmdl
dF9taWJfbmFtZSh1bnNpZ25lZCBsb25nIGlkKTsKK2NvbnN0IGNoYXIgKmdldF9yZWdfbmFtZSh1
bnNpZ25lZCBsb25nIGlkKTsKKworI2VuZGlmCi0tIAoyLjI5LjIKCg==
