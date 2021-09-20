Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE16F41196C
	for <lists+linux-mmc@lfdr.de>; Mon, 20 Sep 2021 18:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbhITQQX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 Sep 2021 12:16:23 -0400
Received: from mail-bn7nam10on2062.outbound.protection.outlook.com ([40.107.92.62]:32097
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242945AbhITQOv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Sep 2021 12:14:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO02CzR5d4tyMc4UELSzpqMjL22cTT7PrxhLhycOQxzaiwLkS5IjDz88t/5K/iX1DUGjoxDHCsYsKF4INQnzZ89M4F7/9pmra9TqEJk/Fh/mhTxvYD8o0UuE465nYrNUb5tsZNZzRwWANG63ixgS8gKZ+5zMXn5rV4LbWumhWlecPbOeJKCrsOhGKdbZSxD+xSzid8ULPjmk6u15NyB4nEzEeWAhEAi3B4aH5f6VeCtU4V8RGtinCvnUsjWr1tz6mj60EIIP1l8gLaicBKFIaGauOGdN3Zi5sT3UwhWH3YxDYd2N9SfUFzrOzAzMuB6ilTFaPTVOzAoV9aSS8BEtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fZ2JaKzYlrdGaX+6E4MBhFuNexc43HZ2kCx0dbW2tZY=;
 b=NIppATt6E26d+sZ8X1j84lG5ypyO0gR9GnznwYWioltKKLHPNlUWouhOBAX++8t1egR44ZvYBR3TVzjtVqjACnt6+V8T0EgHqZ1h7fM+OSOWEIROeCJGWTKlTsmk87mHVulievPfG4lJsLCEaiy8Zl6+Y8HJwifMMXE6MqDjJ1B1yPRhHm+rOYSw0qHEAwsDLFTjDRwwbOkerSRLjXXmFWcyWs46hwHwiTUCmwDhrVUpYgpb9gifnc4BYqmPj7vFcflIeEnWCi27aw5Yfley9foJuHqQXk5ZiO4gnyc+64Xijuw7hNuUvmefwSiK0bOcTCGVasxTqlL8HtA5glbwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ2JaKzYlrdGaX+6E4MBhFuNexc43HZ2kCx0dbW2tZY=;
 b=A6/DfwDMXjkb2KR1PKA+MqbMtWgHb5dGp390NFZYtSdcrFy5fXbs2bdPqTueK5BfsGZellgyRVh/oUdwJb3l+waxCcm3CkCsiIz5LWGVDX5+FBDfUVrCfQvBEZmx0pCR/nCL94X2LtfIRUOAvHwCbCrJPzbTHVRNxDuIRe2Y1sw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB2654.namprd11.prod.outlook.com (2603:10b6:805:54::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 16:12:45 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd%7]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 16:12:45 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v7 21/24] wfx: add debug.c/debug.h
Date:   Mon, 20 Sep 2021 18:11:33 +0200
Message-Id: <20210920161136.2398632-22-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210920161136.2398632-1-Jerome.Pouiller@silabs.com>
References: <20210920161136.2398632-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SA0PR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:806:d2::9) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
Received: from pc-42.silabs.com (2a01:e34:ecb5:66a0:9876:e1d7:65be:d294) by SA0PR11CA0064.namprd11.prod.outlook.com (2603:10b6:806:d2::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 16:12:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 344e979e-0de9-42d9-aefe-08d97c517b6c
X-MS-TrafficTypeDiagnostic: SN6PR11MB2654:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB2654675BB9FA65C14F3DB17693A09@SN6PR11MB2654.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjC/EYYXametWwfKlvlA9jCCvXIspndYkO+qLr5PFEcIeA/wrYgzzVNbTIYRG61hcR8mj56GFMJ0BNrY3xvNm68Ox3W54k8MJAARa0+ubcSj2FrfDR859VC69wJLMU6I2tIRAYQiW08XTphZqVajYz+8Yif79O40SE6T0ftjyLaqJffxSxq5gyLY6IHn4Ze1Dyfu1NWDu4Hi6Sg0cvdEnn5opNa3T0xUmMp8EHI/zYBXa+upokeU1uZsv5HyMiXqZjrOqNl3noLQHtwZOvJXvJ3cwo876ts2fG+BYydRpVBUndpDGs/jSP4YLbctBjK1gdjKtwg+IEtvSYTUjzP8iOXTq8dAtgmlmY3FflOZ9/AglKLQ8KVIcbrtEDwO+Glt1jNAXvwiYHUp38RSamCnxYwbuOTE599tVPQhKwJ5aaKjuy44C7sHJGXx0WVXk0SETec19LHsnT/y+NFZLTDliln8Chm+0KiRKPnzf/WcQ7/AMwseRFw6radazktoas3t69rSlNAiJVOhuscLaRSVMLPocGIQI9usBE+dCYKY+IcerxwZPLnpWPte+OHg+y6Jxmdz/RWwp9OySqcvsE77fSIRkxQPkvQ1Qz7lcJDRmZ7gIzrlIsCcQUDNYjykCxD42mOpopXL6qiuOitT3Jjc5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(36756003)(7696005)(30864003)(5660300002)(4326008)(316002)(107886003)(8676002)(2616005)(2906002)(66476007)(66946007)(66556008)(66574015)(7416002)(508600001)(86362001)(38100700002)(83380400001)(8936002)(1076003)(6486002)(186003)(6916009)(6666004)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YCKh1wuEsa+K2LZ0IB0RXI9cYrYSDu264vy0RwLeZf9L/K0fT1zQuKj4vzmY1RnvpU2Q9/TeKhhIH7Hj5vEkB0fDH/sNnLuPJAU8H2aOutKTCGFpUQVgGAMVTIc4G9iV0K2PBgpGZhrCPZ50+N9tx1l+uLbLeDyQ2ndLjnYFQdhkrPUfncHiklJhuvAijtGgDUke3GuC8oWlBaJ4nFxo75aUY+LZDPlXhboi83Hvq+spJ9Zptc6Ll0TAchJWm0+83sBPqYP3Up3HntnENRK63lZqgMul/bq9gf8xUvAsSrOZF6jkxyEGDLWExA3qiB3XG0uz3ZLm/h6hEQcfqGjjK5//m/e6Naq7x9RXKYxysIxAmypWHCVe7rvGiduVPoywC6yDlQiKwWPMX7dfL4Z4LhkaXQarNGI7LRMFRsUoJL3n+9Ww3JgG8Xc3cyyeZeobuUmp4jV6NOwD6N77VgXMGSPkOZ/p3SzTuznmRBCPHQchwvEVpjDT4SN/PNHomJo0dFhd7avLDxxJezaYxZder8/PsYbv/54IvafBBHKOzakWFg4adxDpdmfffMe4jzTKBO0xPFT2fisGvWC1Jt8HAUJoA4IVmm7Qrl6E/9hPhUQI49IOVGtIYNDrokQTVlxSjTZCxzsOb5jDqR7/GQLrfD3cRYRyfVQfCZKPVB9Nm1zmKx9aAW2YTswh21v9sPNa0chygS8Y20I6/xSsjFoS3ua0EbDSD8ey6ezPS3MDJJdY3ZcWPNPXG5/9YsX+CUJOj1YhT1w4Yjb2HZRwtrcU7HT/r6Nmk2NZN3JUZdWF5ZbKpr8THlgXyy2KZceJD7Jx
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344e979e-0de9-42d9-aefe-08d97c517b6c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 16:12:45.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Adii01UJSaGrng0Oa+SCwyA3EssSINHEZLBtyv2PXz6SUHPmBFMU6WVfmXcIb/UiITejnMG2fpfM1C5hgaXACw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2654
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYyB8IDM2NSArKysr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVi
dWcuaCB8ICAxOSArKwogMiBmaWxlcyBjaGFuZ2VkLCAzODQgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYwogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuaAoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYwpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMDAuLjlmOTMyNjhhMzIwMgotLS0gL2Rldi9udWxsCisrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYwpAQCAtMCwwICsxLDM2NSBAQAor
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
b3VudF8jI25hbWUpKQorCisJUFVUX0NPVU5URVIodHhfZnJhbWVzKTsKKwlQVVRfQ09VTlRFUih0
eF9mcmFtZXNfbXVsdGljYXN0KTsKKwlQVVRfQ09VTlRFUih0eF9mcmFtZXNfc3VjY2Vzcyk7CisJ
UFVUX0NPVU5URVIodHhfZnJhbWVzX3JldHJpZWQpOworCVBVVF9DT1VOVEVSKHR4X2ZyYW1lc19t
dWx0aV9yZXRyaWVkKTsKKwlQVVRfQ09VTlRFUih0eF9mcmFtZXNfZmFpbGVkKTsKKworCVBVVF9D
T1VOVEVSKGFja19mYWlsZWQpOworCVBVVF9DT1VOVEVSKHJ0c19zdWNjZXNzKTsKKwlQVVRfQ09V
TlRFUihydHNfZmFpbGVkKTsKKworCVBVVF9DT1VOVEVSKHJ4X2ZyYW1lcyk7CisJUFVUX0NPVU5U
RVIocnhfZnJhbWVzX211bHRpY2FzdCk7CisJUFVUX0NPVU5URVIocnhfZnJhbWVzX3N1Y2Nlc3Mp
OworCVBVVF9DT1VOVEVSKHJ4X2ZyYW1lc19mYWlsZWQpOworCVBVVF9DT1VOVEVSKGRyb3BfcGxj
cCk7CisJUFVUX0NPVU5URVIoZHJvcF9mY3MpOworCVBVVF9DT1VOVEVSKGRyb3Bfbm9fa2V5KTsK
KwlQVVRfQ09VTlRFUihkcm9wX2RlY3J5cHRpb24pOworCVBVVF9DT1VOVEVSKGRyb3BfdGtpcF9t
aWMpOworCVBVVF9DT1VOVEVSKGRyb3BfYmlwX21pYyk7CisJUFVUX0NPVU5URVIoZHJvcF9jbWFj
X2ljdik7CisJUFVUX0NPVU5URVIoZHJvcF9jbWFjX3JlcGxheSk7CisJUFVUX0NPVU5URVIoZHJv
cF9jY21wX3JlcGxheSk7CisJUFVUX0NPVU5URVIoZHJvcF9kdXBsaWNhdGUpOworCisJUFVUX0NP
VU5URVIocnhfYmNuX21pc3MpOworCVBVVF9DT1VOVEVSKHJ4X2Jjbl9zdWNjZXNzKTsKKwlQVVRf
Q09VTlRFUihyeF9iY25fZHRpbSk7CisJUFVUX0NPVU5URVIocnhfYmNuX2R0aW1fYWlkMF9jbHIp
OworCVBVVF9DT1VOVEVSKHJ4X2Jjbl9kdGltX2FpZDBfc2V0KTsKKworI3VuZGVmIFBVVF9DT1VO
VEVSCisKKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShjb3VudGVyc1swXS5yZXNlcnZlZCk7
IGkrKykKKwkJc2VxX3ByaW50ZihzZXEsICJyZXNlcnZlZFslMDJkXSUxMnMgJTEyZCAlMTJkICUx
MmRcbiIsIGksICIiLAorCQkJICAgbGUzMl90b19jcHUoY291bnRlcnNbMl0ucmVzZXJ2ZWRbaV0p
LAorCQkJICAgbGUzMl90b19jcHUoY291bnRlcnNbMF0ucmVzZXJ2ZWRbaV0pLAorCQkJICAgbGUz
Ml90b19jcHUoY291bnRlcnNbMV0ucmVzZXJ2ZWRbaV0pKTsKKworCXJldHVybiAwOworfQorREVG
SU5FX1NIT1dfQVRUUklCVVRFKHdmeF9jb3VudGVycyk7CisKK3N0YXRpYyBjb25zdCBjaGFyICog
Y29uc3QgY2hhbm5lbF9uYW1lc1tdID0geworCVswXSA9ICIxTSIsCisJWzFdID0gIjJNIiwKKwlb
Ml0gPSAiNS41TSIsCisJWzNdID0gIjExTSIsCisJLyogRW50cmllcyA0IGFuZCA1IGRvZXMgbm90
IGV4aXN0ICovCisJWzZdID0gIjZNIiwKKwlbN10gPSAiOU0iLAorCVs4XSA9ICIxMk0iLAorCVs5
XSA9ICIxOE0iLAorCVsxMF0gPSAiMjRNIiwKKwlbMTFdID0gIjM2TSIsCisJWzEyXSA9ICI0OE0i
LAorCVsxM10gPSAiNTRNIiwKKwlbMTRdID0gIk1DUzAiLAorCVsxNV0gPSAiTUNTMSIsCisJWzE2
XSA9ICJNQ1MyIiwKKwlbMTddID0gIk1DUzMiLAorCVsxOF0gPSAiTUNTNCIsCisJWzE5XSA9ICJN
Q1M1IiwKKwlbMjBdID0gIk1DUzYiLAorCVsyMV0gPSAiTUNTNyIsCit9OworCitzdGF0aWMgaW50
IHdmeF9yeF9zdGF0c19zaG93KHN0cnVjdCBzZXFfZmlsZSAqc2VxLCB2b2lkICp2KQoreworCXN0
cnVjdCB3ZnhfZGV2ICp3ZGV2ID0gc2VxLT5wcml2YXRlOworCXN0cnVjdCBoaWZfcnhfc3RhdHMg
KnN0ID0gJndkZXYtPnJ4X3N0YXRzOworCWludCBpOworCisJbXV0ZXhfbG9jaygmd2Rldi0+cnhf
c3RhdHNfbG9jayk7CisJc2VxX3ByaW50ZihzZXEsICJUaW1lc3RhbXA6ICVkdXNcbiIsIHN0LT5k
YXRlKTsKKwlzZXFfcHJpbnRmKHNlcSwgIkxvdyBwb3dlciBjbG9jazogZnJlcXVlbmN5ICV1SHos
IGV4dGVybmFsICVzXG4iLAorCQkgICBsZTMyX3RvX2NwdShzdC0+cHdyX2Nsa19mcmVxKSwKKwkJ
ICAgc3QtPmlzX2V4dF9wd3JfY2xrID8gInllcyIgOiAibm8iKTsKKwlzZXFfcHJpbnRmKHNlcSwK
KwkJICAgIk51bS4gb2YgZnJhbWVzOiAlZCwgUEVSICh4MTBlNCk6ICVkLCBUaHJvdWdocHV0OiAl
ZEticHMvc1xuIiwKKwkJICAgc3QtPm5iX3J4X2ZyYW1lLCBzdC0+cGVyX3RvdGFsLCBzdC0+dGhy
b3VnaHB1dCk7CisJc2VxX3B1dHMoc2VxLCAiICAgICAgIE51bS4gb2YgICAgICBQRVIgICAgIFJT
U0kgICAgICBTTlIgICAgICBDRk9cbiIpOworCXNlcV9wdXRzKHNlcSwgIiAgICAgICAgZnJhbWVz
ICAoeDEwZTQpICAgIChkQm0pICAgICAoZEIpICAgIChrSHopXG4iKTsKKwlmb3IgKGkgPSAwOyBp
IDwgQVJSQVlfU0laRShjaGFubmVsX25hbWVzKTsgaSsrKSB7CisJCWlmIChjaGFubmVsX25hbWVz
W2ldKQorCQkJc2VxX3ByaW50ZihzZXEsICIlNXMgJThkICU4ZCAlOGQgJThkICU4ZFxuIiwKKwkJ
CQkgICBjaGFubmVsX25hbWVzW2ldLAorCQkJCSAgIGxlMzJfdG9fY3B1KHN0LT5uYl9yeF9ieV9y
YXRlW2ldKSwKKwkJCQkgICBsZTE2X3RvX2NwdShzdC0+cGVyW2ldKSwKKwkJCQkgICAoczE2KWxl
MTZfdG9fY3B1KHN0LT5yc3NpW2ldKSAvIDEwMCwKKwkJCQkgICAoczE2KWxlMTZfdG9fY3B1KHN0
LT5zbnJbaV0pIC8gMTAwLAorCQkJCSAgIChzMTYpbGUxNl90b19jcHUoc3QtPmNmb1tpXSkpOwor
CX0KKwltdXRleF91bmxvY2soJndkZXYtPnJ4X3N0YXRzX2xvY2spOworCisJcmV0dXJuIDA7Cit9
CitERUZJTkVfU0hPV19BVFRSSUJVVEUod2Z4X3J4X3N0YXRzKTsKKworc3RhdGljIGludCB3Znhf
dHhfcG93ZXJfbG9vcF9zaG93KHN0cnVjdCBzZXFfZmlsZSAqc2VxLCB2b2lkICp2KQoreworCXN0
cnVjdCB3ZnhfZGV2ICp3ZGV2ID0gc2VxLT5wcml2YXRlOworCXN0cnVjdCBoaWZfdHhfcG93ZXJf
bG9vcF9pbmZvICpzdCA9ICZ3ZGV2LT50eF9wb3dlcl9sb29wX2luZm87CisJaW50IHRtcDsKKwor
CW11dGV4X2xvY2soJndkZXYtPnR4X3Bvd2VyX2xvb3BfaW5mb19sb2NrKTsKKwl0bXAgPSBsZTE2
X3RvX2NwdShzdC0+dHhfZ2Fpbl9kaWcpOworCXNlcV9wcmludGYoc2VxLCAiVHggZ2FpbiBkaWdp
dGFsOiAlZFxuIiwgdG1wKTsKKwl0bXAgPSBsZTE2X3RvX2NwdShzdC0+dHhfZ2Fpbl9wYSk7CisJ
c2VxX3ByaW50ZihzZXEsICJUeCBnYWluIFBBOiAlZFxuIiwgdG1wKTsKKwl0bXAgPSAoczE2KWxl
MTZfdG9fY3B1KHN0LT50YXJnZXRfcG91dCk7CisJc2VxX3ByaW50ZihzZXEsICJUYXJnZXQgUG91
dDogJWQuJTAyZCBkQm1cbiIsIHRtcCAvIDQsICh0bXAgJSA0KSAqIDI1KTsKKwl0bXAgPSAoczE2
KWxlMTZfdG9fY3B1KHN0LT5wX2VzdGltYXRpb24pOworCXNlcV9wcmludGYoc2VxLCAiRkVNIFBv
dXQ6ICVkLiUwMmQgZEJtXG4iLCB0bXAgLyA0LCAodG1wICUgNCkgKiAyNSk7CisJdG1wID0gbGUx
Nl90b19jcHUoc3QtPnZwZGV0KTsKKwlzZXFfcHJpbnRmKHNlcSwgIlZwZGV0OiAlZCBtVlxuIiwg
dG1wKTsKKwlzZXFfcHJpbnRmKHNlcSwgIk1lYXN1cmUgaW5kZXg6ICVkXG4iLCBzdC0+bWVhc3Vy
ZW1lbnRfaW5kZXgpOworCW11dGV4X3VubG9jaygmd2Rldi0+dHhfcG93ZXJfbG9vcF9pbmZvX2xv
Y2spOworCisJcmV0dXJuIDA7Cit9CitERUZJTkVfU0hPV19BVFRSSUJVVEUod2Z4X3R4X3Bvd2Vy
X2xvb3ApOworCitzdGF0aWMgc3NpemVfdCB3Znhfc2VuZF9wZHNfd3JpdGUoc3RydWN0IGZpbGUg
KmZpbGUsCisJCQkJICBjb25zdCBjaGFyIF9fdXNlciAqdXNlcl9idWYsCisJCQkJICBzaXplX3Qg
Y291bnQsIGxvZmZfdCAqcHBvcykKK3sKKwlzdHJ1Y3Qgd2Z4X2RldiAqd2RldiA9IGZpbGUtPnBy
aXZhdGVfZGF0YTsKKwljaGFyICpidWY7CisJaW50IHJldDsKKworCWlmICgqcHBvcyAhPSAwKSB7
CisJCWRldl9kYmcod2Rldi0+ZGV2LCAiUERTIGRhdGEgbXVzdCBiZSB3cml0dGVuIGluIG9uZSB0
cmFuc2FjdGlvbiIpOworCQlyZXR1cm4gLUVCVVNZOworCX0KKwlidWYgPSBtZW1kdXBfdXNlcih1
c2VyX2J1ZiwgY291bnQpOworCWlmIChJU19FUlIoYnVmKSkKKwkJcmV0dXJuIFBUUl9FUlIoYnVm
KTsKKwkqcHBvcyA9ICpwcG9zICsgY291bnQ7CisJcmV0ID0gd2Z4X3NlbmRfcGRzKHdkZXYsIGJ1
ZiwgY291bnQpOworCWtmcmVlKGJ1Zik7CisJaWYgKHJldCA8IDApCisJCXJldHVybiByZXQ7CisJ
cmV0dXJuIGNvdW50OworfQorCitzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyB3
Znhfc2VuZF9wZHNfZm9wcyA9IHsKKwkub3BlbiA9IHNpbXBsZV9vcGVuLAorCS53cml0ZSA9IHdm
eF9zZW5kX3Bkc193cml0ZSwKK307CisKK3N0cnVjdCBkYmdmc19oaWZfbXNnIHsKKwlzdHJ1Y3Qg
d2Z4X2RldiAqd2RldjsKKwlzdHJ1Y3QgY29tcGxldGlvbiBjb21wbGV0ZTsKKwl1OCByZXBseVsx
MDI0XTsKKwlpbnQgcmV0OworfTsKKworc3RhdGljIHNzaXplX3Qgd2Z4X3NlbmRfaGlmX21zZ193
cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKKwkJCQkgICAgICBjb25zdCBjaGFyIF9fdXNlciAqdXNl
cl9idWYsCisJCQkJICAgICAgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpCit7CisJc3RydWN0
IGRiZ2ZzX2hpZl9tc2cgKmNvbnRleHQgPSBmaWxlLT5wcml2YXRlX2RhdGE7CisJc3RydWN0IHdm
eF9kZXYgKndkZXYgPSBjb250ZXh0LT53ZGV2OworCXN0cnVjdCBoaWZfbXNnICpyZXF1ZXN0Owor
CisJaWYgKGNvbXBsZXRpb25fZG9uZSgmY29udGV4dC0+Y29tcGxldGUpKSB7CisJCWRldl9kYmco
d2Rldi0+ZGV2LCAicmVhZCBwcmV2aW91cyByZXN1bHQgYmVmb3JlIHN0YXJ0IGEgbmV3IG9uZVxu
Iik7CisJCXJldHVybiAtRUJVU1k7CisJfQorCWlmIChjb3VudCA8IHNpemVvZihzdHJ1Y3QgaGlm
X21zZykpCisJCXJldHVybiAtRUlOVkFMOworCisJLyogd2Z4X2NtZF9zZW5kKCkgY2hlY2tzIHRo
YXQgcmVwbHkgYnVmZmVyIGlzIHdpZGUgZW5vdWdoLCBidXQgZG9lcyBub3QKKwkgKiByZXR1cm4g
cHJlY2lzZSBsZW5ndGggcmVhZC4gVXNlciBoYXZlIHRvIGtub3cgaG93IG1hbnkgYnl0ZXMgc2hv
dWxkCisJICogYmUgcmVhZC4gRmlsbGluZyByZXBseSBidWZmZXIgd2l0aCBhIG1lbW9yeSBwYXR0
ZXJuIG1heSBoZWxwIHVzZXIuCisJICovCisJbWVtc2V0KGNvbnRleHQtPnJlcGx5LCAweEZGLCBz
aXplb2YoY29udGV4dC0+cmVwbHkpKTsKKwlyZXF1ZXN0ID0gbWVtZHVwX3VzZXIodXNlcl9idWYs
IGNvdW50KTsKKwlpZiAoSVNfRVJSKHJlcXVlc3QpKQorCQlyZXR1cm4gUFRSX0VSUihyZXF1ZXN0
KTsKKwlpZiAobGUxNl90b19jcHUocmVxdWVzdC0+bGVuKSAhPSBjb3VudCkgeworCQlrZnJlZShy
ZXF1ZXN0KTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCWNvbnRleHQtPnJldCA9IHdmeF9jbWRf
c2VuZCh3ZGV2LCByZXF1ZXN0LCBjb250ZXh0LT5yZXBseSwKKwkJCQkgICAgc2l6ZW9mKGNvbnRl
eHQtPnJlcGx5KSwgZmFsc2UpOworCisJa2ZyZWUocmVxdWVzdCk7CisJY29tcGxldGUoJmNvbnRl
eHQtPmNvbXBsZXRlKTsKKwlyZXR1cm4gY291bnQ7Cit9CisKK3N0YXRpYyBzc2l6ZV90IHdmeF9z
ZW5kX2hpZl9tc2dfcmVhZChzdHJ1Y3QgZmlsZSAqZmlsZSwgY2hhciBfX3VzZXIgKnVzZXJfYnVm
LAorCQkJCSAgICAgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpCit7CisJc3RydWN0IGRiZ2Zz
X2hpZl9tc2cgKmNvbnRleHQgPSBmaWxlLT5wcml2YXRlX2RhdGE7CisJaW50IHJldDsKKworCWlm
IChjb3VudCA+IHNpemVvZihjb250ZXh0LT5yZXBseSkpCisJCXJldHVybiAtRUlOVkFMOworCXJl
dCA9IHdhaXRfZm9yX2NvbXBsZXRpb25faW50ZXJydXB0aWJsZSgmY29udGV4dC0+Y29tcGxldGUp
OworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisJaWYgKGNvbnRleHQtPnJldCA8IDApCisJCXJl
dHVybiBjb250ZXh0LT5yZXQ7CisJLyogQmUgY2FyZWZ1bCwgd3JpdGUoKSBpcyB3YWl0aW5nIGZv
ciBhIGZ1bGwgbWVzc2FnZSB3aGlsZSByZWFkKCkKKwkgKiBvbmx5IHJldHVybnMgYSBwYXlsb2Fk
CisJICovCisJaWYgKGNvcHlfdG9fdXNlcih1c2VyX2J1ZiwgY29udGV4dC0+cmVwbHksIGNvdW50
KSkKKwkJcmV0dXJuIC1FRkFVTFQ7CisKKwlyZXR1cm4gY291bnQ7Cit9CisKK3N0YXRpYyBpbnQg
d2Z4X3NlbmRfaGlmX21zZ19vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpm
aWxlKQoreworCXN0cnVjdCBkYmdmc19oaWZfbXNnICpjb250ZXh0ID0ga3phbGxvYyhzaXplb2Yo
KmNvbnRleHQpLCBHRlBfS0VSTkVMKTsKKworCWlmICghY29udGV4dCkKKwkJcmV0dXJuIC1FTk9N
RU07CisJY29udGV4dC0+d2RldiA9IGlub2RlLT5pX3ByaXZhdGU7CisJaW5pdF9jb21wbGV0aW9u
KCZjb250ZXh0LT5jb21wbGV0ZSk7CisJZmlsZS0+cHJpdmF0ZV9kYXRhID0gY29udGV4dDsKKwly
ZXR1cm4gMDsKK30KKworc3RhdGljIGludCB3Znhfc2VuZF9oaWZfbXNnX3JlbGVhc2Uoc3RydWN0
IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCit7CisJc3RydWN0IGRiZ2ZzX2hpZl9t
c2cgKmNvbnRleHQgPSBmaWxlLT5wcml2YXRlX2RhdGE7CisKKwlrZnJlZShjb250ZXh0KTsKKwly
ZXR1cm4gMDsKK30KKworc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgd2Z4X3Nl
bmRfaGlmX21zZ19mb3BzID0geworCS5vcGVuID0gd2Z4X3NlbmRfaGlmX21zZ19vcGVuLAorCS5y
ZWxlYXNlID0gd2Z4X3NlbmRfaGlmX21zZ19yZWxlYXNlLAorCS53cml0ZSA9IHdmeF9zZW5kX2hp
Zl9tc2dfd3JpdGUsCisJLnJlYWQgPSB3Znhfc2VuZF9oaWZfbXNnX3JlYWQsCit9OworCitzdGF0
aWMgaW50IHdmeF9wc190aW1lb3V0X3NldCh2b2lkICpkYXRhLCB1NjQgdmFsKQoreworCXN0cnVj
dCB3ZnhfZGV2ICp3ZGV2ID0gKHN0cnVjdCB3ZnhfZGV2ICopZGF0YTsKKwlzdHJ1Y3Qgd2Z4X3Zp
ZiAqd3ZpZjsKKworCXdkZXYtPmZvcmNlX3BzX3RpbWVvdXQgPSB2YWw7CisJd3ZpZiA9IE5VTEw7
CisJd2hpbGUgKCh3dmlmID0gd3ZpZl9pdGVyYXRlKHdkZXYsIHd2aWYpKSAhPSBOVUxMKQorCQl3
ZnhfdXBkYXRlX3BtKHd2aWYpOworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHdmeF9wc190
aW1lb3V0X2dldCh2b2lkICpkYXRhLCB1NjQgKnZhbCkKK3sKKwlzdHJ1Y3Qgd2Z4X2RldiAqd2Rl
diA9IChzdHJ1Y3Qgd2Z4X2RldiAqKWRhdGE7CisKKwkqdmFsID0gd2Rldi0+Zm9yY2VfcHNfdGlt
ZW91dDsKKwlyZXR1cm4gMDsKK30KKworREVGSU5FX0RFQlVHRlNfQVRUUklCVVRFKHdmeF9wc190
aW1lb3V0X2ZvcHMsIHdmeF9wc190aW1lb3V0X2dldCwgd2Z4X3BzX3RpbWVvdXRfc2V0LCAiJWxs
ZFxuIik7CisKK2ludCB3ZnhfZGVidWdfaW5pdChzdHJ1Y3Qgd2Z4X2RldiAqd2RldikKK3sKKwlz
dHJ1Y3QgZGVudHJ5ICpkOworCisJZCA9IGRlYnVnZnNfY3JlYXRlX2Rpcigid2Z4Iiwgd2Rldi0+
aHctPndpcGh5LT5kZWJ1Z2ZzZGlyKTsKKwlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJjb3VudGVycyIs
IDA0NDQsIGQsIHdkZXYsICZ3ZnhfY291bnRlcnNfZm9wcyk7CisJZGVidWdmc19jcmVhdGVfZmls
ZSgicnhfc3RhdHMiLCAwNDQ0LCBkLCB3ZGV2LCAmd2Z4X3J4X3N0YXRzX2ZvcHMpOworCWRlYnVn
ZnNfY3JlYXRlX2ZpbGUoInR4X3Bvd2VyX2xvb3AiLCAwNDQ0LCBkLCB3ZGV2LAorCQkJICAgICZ3
ZnhfdHhfcG93ZXJfbG9vcF9mb3BzKTsKKwlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJzZW5kX3BkcyIs
IDAyMDAsIGQsIHdkZXYsICZ3Znhfc2VuZF9wZHNfZm9wcyk7CisJZGVidWdmc19jcmVhdGVfZmls
ZSgic2VuZF9oaWZfbXNnIiwgMDYwMCwgZCwgd2RldiwKKwkJCSAgICAmd2Z4X3NlbmRfaGlmX21z
Z19mb3BzKTsKKwlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJwc190aW1lb3V0IiwgMDYwMCwgZCwgd2Rl
diwgJndmeF9wc190aW1lb3V0X2ZvcHMpOworCisJcmV0dXJuIDA7Cit9CmRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RlYnVnLmggYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9zaWxhYnMvd2Z4L2RlYnVnLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MDAwMDAwLi40YjljNDlhOWZmZmIKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9zaWxhYnMvd2Z4L2RlYnVnLmgKQEAgLTAsMCArMSwxOSBAQAorLyogU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLworLyoKKyAqIERlYnVnZnMgaW50ZXJmYWNlLgor
ICoKKyAqIENvcHlyaWdodCAoYykgMjAxNy0yMDE5LCBTaWxpY29uIExhYm9yYXRvcmllcywgSW5j
LgorICogQ29weXJpZ2h0IChjKSAyMDExLCBTVC1Fcmljc3NvbgorICovCisjaWZuZGVmIFdGWF9E
RUJVR19ICisjZGVmaW5lIFdGWF9ERUJVR19ICisKK3N0cnVjdCB3ZnhfZGV2OworCitpbnQgd2Z4
X2RlYnVnX2luaXQoc3RydWN0IHdmeF9kZXYgKndkZXYpOworCitjb25zdCBjaGFyICpnZXRfaGlm
X25hbWUodW5zaWduZWQgbG9uZyBpZCk7Citjb25zdCBjaGFyICpnZXRfbWliX25hbWUodW5zaWdu
ZWQgbG9uZyBpZCk7Citjb25zdCBjaGFyICpnZXRfcmVnX25hbWUodW5zaWduZWQgbG9uZyBpZCk7
CisKKyNlbmRpZgotLSAKMi4zMy4wCgo=
