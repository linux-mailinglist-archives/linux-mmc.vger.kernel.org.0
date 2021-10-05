Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EB2422916
	for <lists+linux-mmc@lfdr.de>; Tue,  5 Oct 2021 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhJEN44 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 5 Oct 2021 09:56:56 -0400
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:3808
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234570AbhJEN4L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 5 Oct 2021 09:56:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuEi+mPPn2oth/Kamq/Kkd157ORpujba315chUai0Z30llrxl91ae5K9ljSLaeBnizKvTEFI0EcRNE24p2VDfpgMlgQQt3o4rWnGxarGtkeMNmMzAFFlVH+osIdsoGSIgIoUm6OQp2GENX3hEBASVOsBw11tOETG+WIPuOS4ZlIgXP/SURvxD7V5XUQrhRrvqzjdYnofwNeOQWC0eEFtAbQCfBS2MPMqqqx//JcIxc7jtePcecmIgjyFIikQLww0ctOeiCmNZyG/G+7EiUXQBrQXWkmjpUfPeSgnkuLukULkHuPf69mAqhnjOcvWgS/VWfe3afLAy5NsZGPg3FNstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/eEVjaEiLkJ7KuCf9W4wxE2tCnb3ptteKpeBmMPRXc=;
 b=KLzvnRXIhhWKcdoZB51c9abUGNPlek+4fzPvODZo1ZqB15fNw9gxLvHO+KSAZqo7d0B4TDk8J3ehqssCBO9PWa/EGNn9Wek69tknZM4iPZXbxSBklwlTWTwnRUqlVsoUuh20vbOvsPt3QjF7iV0Vmw9Q2l58Ya7G6zKrmLRe9MLqLh8Eq4vmq56VPp77fV7zuX8jwQmqroocu6jDYJc4L3oWP1U8OfY97v0mQiiNpyn5YZ3+RXcBiIWVRE7PE4M/ZjfTu27QR4GpJ18/3sE2yX1R9XAaP+au0q7ne2fWTZFwlc3oC/L05SFGDaObQ3ST6jXyJZPrKxXEa5pZDU4Ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/eEVjaEiLkJ7KuCf9W4wxE2tCnb3ptteKpeBmMPRXc=;
 b=cz361h7dthNgrpTRD70cSdqsJyMsKc5YLdjENDkD7ku+eeuqoy0LQPOT8DP8bS57Gv/VaV6+mqQlcHS50MW3CaHCOj4WINaj3htrgOvXk++SwaCLvtQUZ1zAJD3b0BwrSmmvL8euL1rYjEn+LqM86F4bRNy/n7wyOgaBGadRJAw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5642.namprd11.prod.outlook.com (2603:10b6:510:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 13:54:19 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::31cb:3b13:b0e8:d8f4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::31cb:3b13:b0e8:d8f4%9]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 13:54:19 +0000
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
Subject: [PATCH v8 00/24] wfx: get out from the staging area
Date:   Tue,  5 Oct 2021 15:53:36 +0200
Message-Id: <20211005135400.788058-1-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
Received: from pc-42.silabs.com (37.71.187.125) by PR3P189CA0084.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 13:54:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 249956d3-dd40-47b7-9941-08d98807a070
X-MS-TrafficTypeDiagnostic: PH0PR11MB5642:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB5642A90655715C8D7D54005893AF9@PH0PR11MB5642.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfUfAAoMc2fAgF21QP8QHEVBefltp47iCl1ksLR12B7dnCZW/dWFPCRVBTpJzLX0bwKoknYhc1nIA/HxDKHpdNcZERn/fVBVBu/1JkJ0Q+YPXpzV59RNZ5JKoHbhAIcYCPrrtrn1sWdt4kZmprCNAb4s+l3UcilRan3Q0VfU1pdNwvzyT8gTMDrtSt6Bh2FanHVY+276aI75k3mi2XuvCoo6hv7X1q+ihHD88aVDnyIpueMqMa9rgTaGfXqomRjvtK7NN3Z/e58cIM9iHbzUikdFeVGDG5He7XkV+ywoBPjHumf4dwggzLZ52Aa8PYCBOidtnpMy4Hkq+MRKVAwLc4kQ1G/1Xfk3hIJMqheCRuPdJJIZmUYN1Zd+1sgomWXNKSj9TeQrl6BmJEx0XQHY7vMEXNJ/GuWz4nUhpHL18r6Az4aImz2ax6fPfPkTr/f2fl/oEM0ODGHD6SsQydtOTDX8OgfIpxY/Pm8qAFNCXN0zSAD8PL9o1k4uyY+f7QFFKOJbAXXL7zGvff4MARDu5VQLowHKtsYb+sdK6s1oe/4NHYi2+F/n95o1F3+pd0as/1kcNaT0o2mS97cm+P2GoSJdP8ATdQ1lJqLdeJKljvhIXFD3KLnzeG0n9U4rs0R058ArolBijoo7kbPzF/YRRI43op60pcLcCQYttFnKYDkEJinCqM1RT0Yngc3UQ5eTfnLHhoRjKnalPV+lFQi77xbFjiUiBVt4VovYnMkK5utZ0Mmj29UWGSJeqE9WBx7tc7B5jA92lhBUnxVvzjC7YEfQ2dqO/bCKQQ9IzEquLSBwjq36b1V0mICVz/IHdFd3jcHNe305zjEMdfpWw+VLvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(5660300002)(26005)(30864003)(52116002)(7696005)(956004)(8676002)(2616005)(38100700002)(8936002)(38350700002)(4326008)(6666004)(186003)(7416002)(6916009)(66574015)(107886003)(83380400001)(36756003)(66476007)(66556008)(508600001)(2906002)(966005)(316002)(6486002)(1076003)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC9KN1RsM3QybHI3ZE9OMFQ0c004VWdUZHFrS05UcHVVZE1qNjdGVmo4Mndy?=
 =?utf-8?B?bjM1bndPa3NDbkdsT2RDMFQrVXJPOFp5TGYyVDNIZEdaUTc1OElzR0g3TzhN?=
 =?utf-8?B?RHhnYyt0MUlFUFB0L29mSWMwOVhyT2d0OUpWeHBaUFg0a0V6em9JK2VobWxV?=
 =?utf-8?B?dklqTVgvdkZLczR1emdNT2pzNHhNK1dIY2F4dXZLZTl5ZkMwMVY3M3FIZ3VG?=
 =?utf-8?B?ZUZrY25nM01BMWVWVkxnWUF0eis2cFExVjd4M1lKS1N1QWFZVUVWcXp0a21W?=
 =?utf-8?B?NFFjWFZDcE1tTjU3YTN0RUZnNmpVQzUwa3I0MFMwZy9qaDBrb0RkeUd1NExI?=
 =?utf-8?B?Q0hiam9JRllIZWU2aFFkWkl5d3VDV0tlU0JaQ2ZweGhJdC9tby9iaHN2RW82?=
 =?utf-8?B?VWF2c3RNdWtPZGV1cS9KaHB4azl2QzY3NGltbEpUclovNEtQei9tSGNmZGxr?=
 =?utf-8?B?dmljYVQrNFo4VVJmUGFmdFhJNzFuUnNpRUMyQ21qaDJZVzZPdk0rc2NaSFV0?=
 =?utf-8?B?NmRrNHNjeFNmVXdsMS9UazdGSldMOEczajJwMDYvN0JET2VvK1VhZ29YbDVv?=
 =?utf-8?B?c2dnRXBUclhRbWxncWpXKy9hN0JwcSs4djJ5dWJYbUVFdDExZ0lncHZldHdr?=
 =?utf-8?B?VkpVcDg4SXZyUlYxcC9zUnBxYkVrRytzTDllazI4Z1Z2UDlWcnNlNGRER3JN?=
 =?utf-8?B?WkFOR2tGdmR5OXJLK1ZzSU1ncis4UnpKMEw1S1FFd3h1dU5vQ1JrS3ZkQjh5?=
 =?utf-8?B?cVljMWR3cjNmL2grV2E4QUxFN0lnamgrYUtOUlJhVkE5S0pPYWdqS2ZkYkRV?=
 =?utf-8?B?N2x4eVhqeUdLRDJGSEdlQTFCc2JhK1cweDdpUTNqT2NNUEtSdVhlVS9sdDlU?=
 =?utf-8?B?WGdJdWo5VndrM0NOcjErTEVzaFdzekx5L0EvcXJxK0hTZEloMjM3OERsWmsv?=
 =?utf-8?B?V3ZRekFzRzJPenFiSm9HL0E5S0VqRE14TlM4TGlMVDFqU3NXWUUvbmdXTmhG?=
 =?utf-8?B?cS9kSmZJMnpMQjFRckFFNVVjdFVaNWJIZ2I3MDZZSC9MMlEveHM1YXFuWUFt?=
 =?utf-8?B?RysraWJEb1RSa0dWa1Fqa05rd3Vzd1h1TWY4QXZNVG9wYnFsYXhxYTNLYkx6?=
 =?utf-8?B?Y2FFbjltUUMzdHlNRkgyZTlvM1RqbFdYeVFpN1NtZC9qYWUyR3c0UVI1RGpy?=
 =?utf-8?B?Ukw4Y3IxdVlDM0JINFMvR2lNRnNDb0JDVGVFRXRxSEFoekZzTlZkQnIxdkRm?=
 =?utf-8?B?eG9IVEdHVnErT0FaYm51Q3MzaVZXc3NxZGRTTUNRRzlMb05FU2F6UjZCdGx4?=
 =?utf-8?B?WUZNWG96RUdqMDhWSFUzTm5CVjF0WnMwKzBJWDFxSW9yNkp4dnFCdkV6K1M1?=
 =?utf-8?B?U1RqdnpUZGRQT3BwZ2lXRWRIZE9aR2tFbzJwQnRVOEJMUDBleVJDK0FLYzNo?=
 =?utf-8?B?dkhydXdTSWwraTdQVmVZelFlbWJRMWV2MW5OR2IrSEtBaWh5NklpMTZHTFdx?=
 =?utf-8?B?azk0aEZOV21KM0F2cWtLdXFUM2czcmV3Tm5ZWDlIS0FheUJyVk50ZURSTzhL?=
 =?utf-8?B?alNGVE8yTWF5ajBxRVJ1Q2lOcmJkZm4zQk9WQVVLaUVRRXQwYTdkaWVHTTRX?=
 =?utf-8?B?TlZ5UHZDalRFK0NKRlBpRkFQdnJXc1Zac1N3RGg2UTZPSEJzaExNbnlUZFlm?=
 =?utf-8?B?SGNZSEU3bHN6UVBjZG9xT1BQZ0RkWU9uRTZ6ZFRobG9MU1JyZ2wxT0hLa2lH?=
 =?utf-8?Q?sGPuUJiwK+zrKW0ThV1q6ViBnfzY/LO28Oq/r3r?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249956d3-dd40-47b7-9941-08d98807a070
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 13:54:19.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mF+nqZRFg2jDsa1iBGI992PQR26Kfcs2I3CdDY1f9q75BjhuTrg0cw/Bq4lfVtd0v+sVRLWSa6McVdK4jymVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5642
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKSGVs
bG8sCgpJIHRoaW5rIHRoZSB3ZnggZHJpdmVyIGlzIG5vdyBtYXR1cmUgZW5vdWdoIHRvIGJlIGFj
Y2VwdGVkIGluIHRoZQpkcml2ZXJzL25ldC93aXJlbGVzcyBkaXJlY3RvcnkuCgpUaGUgZmlybXdh
cmUgaXMgbm93IGEgcGFydCBvZiB0aGUgbGludXgtZmlybXdhcmUgcmVwb3NpdG9yeSBzaW5jZSBy
ZWxhc2UKMjAyMTAzMTVbMV0uIEl0IGhhZCB0YWtlbiBhIGJpdCBvZiB0aW1lIGJlY2F1c2UgSSBo
YXZlIHdvcmtlZCB3aXRoIHRoZSBsZWdhbApkZXBhcnRtZW50IHRvIHNpbXBsaWZ5IHRoZSByZWRp
c3RyaWJ1dGlvbiB0ZXJtcyBvZiB0aGUgZmlybXdhcmUuCgpbMV06IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWZpcm13YXJlLzI4MzMzNTQuZ1h2VmZhQzRJN0BwYy00Mi8KCgpBcyByZXF1
ZXN0ZWQgYnkgS2FsbGVbMl0sIEkgc2VuZCBvbmUgZmlsZSBwZXIgcGF0Y2guIEF0IHRoZSBlbmQs
IGFsbCB0aGUKcGF0Y2hlcyAob3IgYXQgbGVhc3QgdGhlIHBhdGNoZXMgMyB0byAyNCkgd2lsbCBi
ZSBzcXVhc2hlZCAodGhlcmVmb3JlLCBJCmRpZG4ndCBib3RoZXIgdG8gd3JpdGUgcmVhbCBjb21t
aXQgbWVzc2FnZXMpLgoKWzJdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzg3ZnQ2cDJu
MGguZnNmQGNvZGVhdXJvcmEub3JnLwoKSGVyZSBpcyBhIGRpYWdyYW0gb2YgdGhlIGdsb2JhbCBh
cmNoaXRlY3R1cmUgdGhhdCBtYXkgaGVscCB0byB1bmRlcnN0YW5kCnRoZSBjb2RlOgoKICAgICwt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0uCiAgICB8ICAgICAgICAgICAgICAg
IG1hYzgwMjExICAgICAgICAgICAgfAogICAgYC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLScKICAgICwtLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0uCiAgICB8
ICAgIHN0YSAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAgfAogICAgfCAgICBzY2FuICAgIHwg
ICAgICAgICAgIHwgICAgICAgICAgIHwKICAgIHwgICAgbWFpbiAgICB8ICAgICAgICAgICB8ICAg
ICAgICAgICB8CiAgICArLS0tLS0tLS0tLS0tKyAgZGF0YV90eCAgfCAgICAgICAgICAgfAogICAg
fCAgICBrZXkgICAgIHwgICAgICAgICAgIHwgIGRhdGFfcnggIHwKICAgIHwgaGlmX3R4X21pYiB8
ICAgcXVldWUgICB8ICAgICAgICAgICB8CiAgICB8ICAgaGlmX3R4ICAgfCAgICAgICAgICAgfCAg
ICAgICAgICAgfAogICAgfCAgIGhpZl9yeCAgIHwgICAgICAgICAgIHwgICAgICAgICAgIHwKICAg
IHwgIGhpZl9hcGlfKiB8ICAgICAgICAgICB8ICAgICAgICAgICB8CiAgICArLS0tLS0tLS0tLS0t
Ky0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0tLgogICAgfCAgICAgICAgICAgICAgICAg
IGJoICAgICAgICAgICAgICAgIHwgIGZ3aW8gIHwKICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0rCiAgICB8ICAgICAgICAgICAgICAgICAgICAgaHdpbyAg
ICAgICAgICAgICAgICAgICAgfAogICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSsKICAgIHwgICAgICAgICAgICAgICAgICAgYnVzX3NkaW8gICAgICAgICAg
ICAgICAgICB8CiAgICB8ICAgICAgICAgICAgICAgICAgIGJ1c19zcGkgICAgICAgICAgICAgICAg
ICAgfAogICAgYC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLScK
ICAgICwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0uCiAgICB8
ICAgICAgICAgICAgICAgICAgc3BpIC8gc2RpbyAgICAgICAgICAgICAgICAgfAogICAgYC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLScKClJvdWdobHksIEkgaGF2
ZSBzZW50IHRoZSBmaWxlcyBmcm9tIHRoZSBib3R0b20gdG8gdGhlIHRvcC4KCgp2ODoKICAtIENo
YW5nZSB0aGUgd2F5IHRoZSBEVCBpcyBoYW5kbGVkLiBUaGUgdXNlciBjYW4gbm93IHNwZWNpZnkg
dGhlIG5hbWUgb2YKICAgIHRoZSBib2FyZCAoPSBjaGlwICsgYW50ZW5uYSkgaGUgdXNlLiBJdCBl
YXNpZXIgZm9yIGJvYXJkIGRlc2lnbmVycyB0bwogICAgYWRkIG5ldyBlbnRyaWVzLiBJIHBsYW4g
dG8gc2VuZCBhIFBSIHRvIGxpbnV4LWZpcm13YXJlIHRvIGluY2x1ZGUgUERTCiAgICBmaWxlcyBv
ZiB0aGUgZGV2ZWxvcHBlbWVudCBib2FyZHMgYmVsb25nIHRoZSBmaXJtd2FyZSAoSSBhbHNvIHBs
YW4gdG8KICAgIHJlbG9jYXRlIHRoZXNlIGZpbGUgaW50byB3ZngvIGluc3RlYWQgb2Ygc2lsYWJz
LykuIChLYWxsZSwgUGFsaSkKICAtIFByZWZpeCB2aXNpYmxlIGZ1bmN0aW9ucyBhbmQgc3RydWN0
cyB3aXRoICJ3ZnhfIi4gSSBtb3N0bHkga2VwdCB0aGUKICAgIGNvZGUgdW5kZXIgODAgY29sdW1u
cy4gKEthbGxlLCBQYWxpLCBHcmVnKQogIC0gUmVtb3ZlIHN1cHBvcnQgZm9yIGZvcmNlX3BzX3Rp
bWVvdXQgZm9yIG5vdy4gKEthbGxlKQogIC0gRml4IGxpY2Vuc2VzIG9mIE1ha2VmaWxlLCBLY29u
ZmlnIGFuZCBoaWZfYXBpKi5oLiAoS2FsbGUpCiAgLSBEbyBub3QgbWl4IGFuZCBtYXRjaCBlbmRp
YW5lc3MgaW4gc3RydWN0IGhpZl9pbmRfc3RhcnR1cC4gKEthbGxlKQogIC0gUmVtb3ZlIG1hZ2lj
IHZhbHVlcy4gKEthbGxlKQogIC0gVXNlIElTX0FMSUdORUQoKS4gKEJUVywgUFRSX0lTX0FMSUdO
RUQoKSBkb2VzIG5vdCBleGlzdD8pIChLYWxsZSkKICAtIEkgaGF2ZSBhbHNvIG5vdGljZWQgdGhh
dCBzb21lIGhlYWRlcnMgZmlsZXMgZGlkIG5vdCBkZWNsYXJlIGFsbCB0aGUKICAgIHN0cnVjdCB0
aGV5IHVzZWQuCgogIFRoZXNlIGlzc3VlcyByZW1haW4gKEkgaG9wZSB0aGV5IGFyZSBub3QgYmxv
Y2tlcnMpOgogIC0gSSBoYXZlIGN1cnJlbnRseSBubyBpZGVhcyBob3cgdG8gaW1wcm92ZS9zaW1w
bGlmeSB0aGUgcGFyc2luZyBQRFMgZmlsZS4KICAgIChLYWxsZSkKICAtIFdlIHdvdWxkIGxpa2Ug
dG8gcmVsYXRlIHRoZSBTRElPIHF1aXJrcyBpbnRvIG1tYy9jb3JlL3F1aXJrcy5oLCBidXQgdGhl
CiAgICBBUEkgdG8gZG8gdGhhdCBkb2VzIG5vdCB5ZXQgZXhpc3QuIChVbGYsIFBhbGkpCgp2NzoK
ICAtIFVwZGF0ZSBsb2NhdGlvbiBvZiBtbWMtcHdyc2VxLXNpbXBsZS50eHQgKFJvYikKCnY2Ogog
IC0gUmViYXNlIG9uIGxhc3Qgc3RhZ2luZy1uZXh0IChyb3VnaHRseSBzb21ld2hlcmUgYWZ0ZXIg
dGhlIDUuMTUKICAgIG1lcmdlIHdpbmRvdykuIFNvLCB0aGlzIHNlcmllcyBpbmNsdWRlIHRoZSBw
YXRjaGVzIGZyb206CiAgICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIxMDkx
MzEzMDIwMy4xOTAzNjIyLTEtSmVyb21lLlBvdWlsbGVyQHNpbGFicy5jb20vCgp2NToKICAtIEFk
ZCByZWZlcmVuY2UgdG8gdGhlIFBSIHRvIGxpbnV4LWZpcm13YXJlIGluIHRoZSBjb3ZlciBsZXR0
ZXIKICAtIFJlYmFzZSBvbiBsYXN0IHN0YWdpbmcgdHJlZSAodGhhdCBtYWlubHkgaW5jbHVkZSBj
b21taXQgNmVmZWQwYTY5Nzk0CiAgICAic3RhZ2luZzogd2Z4OiBmaXggcG9zc2libGUgcGFuaWMg
d2l0aCByZS1xdWV1ZWQgZnJhbWVzIiBhbmQgYSBmZXcKICAgIGNvc21ldGljcyBjaGFuZ2VzKQog
IC0gUmVtb3ZlIHVzZWxlc3MgdHJhaWxpbmcgc3BhY2VzIGluIERUIGJpbmRpbmcgKFJvYikKICAt
IEFkZCBhIGNvbW1pdCBtZXNzYWdlIGluIHRoZSBwYXRjaCAyIHNpbmNlIEkgYW0gbm90IHN1cmUg
aXQgd2lsbCBiZQogICAgc3F1YXNoZWQgd2l0aCB0aGUgb3RoZXIgKFJvYikKCnY0OgogIC0gUmVi
YXNlIG9uIGxhc3Qgc3RhZ2luZyB0cmVlCiAgLSBBZGQgJ2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBm
YWxzZScgdG8gdGhlIERUIHNwZWNpZmljYXRpb24gKEkgbWFkZSB0aGF0CiAgICBjaGFuZ2UgYmxp
bmRseSBiZWNhdXNlIEkgYW0gYWJsZSB0byByZXByb2R1Y2UgUm9iJ3MgZXJyb3IpIChSb2IpCiAg
LSBSZXBsYWNlIEMrKyBjb21tZW50cyB3aXRoIEFuc2kgQyBjb21tZW50cyAoS2FsbGUpCiAgLSBD
aGVjayB0aGF0IGV4aXN0aW5nIEFuc2kgQyBjb21tZW50cyBjb21wbHkgd2l0aCBuZXQvICJjb21w
YWN0IiBzdHlsZQogIC0gRHJvcCBvbmUgb2Jzb2xldGUgY29tbWVudAogIC0gUmVtb3ZlIGNvbW1l
bnRzIGFmdGVyICcjZW5kaWYnIGluIGhlYWRlciBmaWxlcwogIC0gUmVtb3ZlIG1hY3JvIHJlZGVm
aW5pdGlvbnMgaW4gaGlmX2FwaV9nZW5lcmFsLmggKEthbGxlKQogIC0gUmVwbGFjZSBjb21waWxl
dGltZV9hc3NlcnQoKSB3aXRoIEJVSUxEX0JVR19PTl9NU0coKSAoS2FsbGUpCiAgLSBSZW5hbWUg
aWVlZTgwMjExX2lzX2FjdGlvbl9iYWNrKCkgKEthbGxlKQogIC0gQWRkIGEgY29tbWVudCBleHBs
YWluaW5nIGhvdyB0aGUgUERTIGlzIHNlbnQgdG8gdGhlIGRldmljZSAoS2FsbGUpCiAgLSBBZGQg
YSBjb21tZW50IGFib3V0IGNhc2Ugd2hlcmUgQ09ORklHX01NQz09bSBpbiB0aGUgTWFrZWZpbGUg
KEthbGxlKQogIC0gRml4IGlycmV2ZWxhbnQgY29tbWVudCBhYm91dCBDT05GSUdfVk1BUF9TVEFD
SyAoS2FsbGUpCiAgLSBUYWxrIGFib3V0IHRoZSB1bnJlbGlhYmxlIFNESU8gVmVuZG9yIElEIGlu
IHRoZSBLY29uZmlnIGhlbHAgKEthbGxlKQogIC0gTWVudGlvbiB0aGUgZmlybXdhcmUgc3RhdHVz
IGluIHRoZSBjb3ZlciBsZXR0ZXIgKEthbGxlKQogIC0gRml4IG1pc2FsaWduZWQgZnVuY3Rpb24g
YXJndW1lbnRzIGluIGtleS5jCgp2MzoKICAtIGR0LWJpbmRpbmdzOiBSZW5hbWUgY29uZmlnLWZp
bGUgcHJvcGVydHkgKFJvYikKICAtIGR0LWJpbmRpbmdzOiBObyBhZGRpdGlvbmFsIHByb3BlcnRp
ZXMgYXJlIGFsbG93ZWQgKHNwaS1tYXgtZnJlcXVlbmN5IGlzCiAgICBhbHJlYWR5IGxpc3RlZCkg
KFJvYikKICAtIGR0LWJpbmRpbmdzOiBSZW1vdmUgcmVmZXJlbmNlcyBmb3IgbWFjLWFkZHJlc3Mg
cHJvcGVydGllcyAoUm9iKQogIC0gUmViYXNlIG9uIHN0YWdpbmcvc3RhZ2luZy1uZXh0Cgp2MjoK
ICAtIGR0LWJpbmRpbmdzOiBJbXByb3ZlIGRldmljZSBkZXNjcmlwdGlvbiBhbmQgYWRkIGxpbmsg
dG8gdGhlIGRhdGFzaGVldAogICAgICAoUm9iKQogIC0gZHQtYmluZGluZ3M6IEFkZCBibGFuayBs
aW5lcyBiZXR3ZWVuIGVhY2ggRFQgcHJvcGVydHkgKFJvYikKICAtIGR0LWJpbmRpbmdzOiBFeHBs
aWNpdGx5IG1lbnRpb24gbWFjLWFkZHJlc3MgYW5kIGxvY2FsLW1hYy1hZGRyZXNzIGFuZAogICAg
ICBhZGQgcmVmZXJlbmNlcyB0byBldGhlcm5ldC1jb250cm9sbGVyLnlhbWwgKFJvYikKICAtIGR0
LWJpbmRpbmdzOiAiY29uZmlnLWZpbGUiIGlzIG5vdCBmb3IgZGV2ZWxvcG1lbnQvZGVidWcgKFJv
YikKICAtIGR0LWJpbmRpbmdzOiBSZW1vdmUgZGVzY3JpcHRpb24gb2YgInNwaS1tYXgtZnJlcXVl
bmN5IiAoUm9iKQogIC0gZHQtYmluZGluZ3M6IFVzZSAiZm9sZGVkIHNjYWxhciIgc3ludGF4IGlu
c3RlYWQgb2YgZXNjYXBpbmcgdGhlIGNvbG9ucwogIC0gYnVzX3NkaW8uYzogQSBjb21wYXRpYmxl
IG5vZGUgaW4gdGhlIERUIGlzIG5vdyBtYW5kYXRvcnkgdG8gcHJvYmUgdGhlCiAgICAgIGRldmlj
ZS4gQWxzbyBjaGFuZ2UgZG9jdW1lbnRhdGlvbiBvZiBkdC1iaW5kaW5ncyBhY2NvcmRpbmdseSAo
UGFsaSwKICAgICAgVWxmKQogIC0gYnVzX3NkaW8uYzogTW92ZSBTRElPIElEcyB0byBzZGlvX2lk
cy5oIChQYWxpKQogIC0gYmguYzogSW1wb3J0IHBhdGNoICJzdGFnaW5nOiB3Zng6IGZpeCB0ZXN0
IG9uIHJldHVybiB2YWx1ZSBvZgogICAgICBncGlvZF9nZXRfdmFsdWUoKSIgKE5hdGhhbikKICAt
IGRhdGFfdHguYzogSW1wb3J0IHBhdGNoICJzdGFnaW5nOiB3Zng6IGZpeCB1c2Ugb2YgdW5pbml0
aWFsaXplZAogICAgICBwb2ludGVyIgogIC0gc3RhLmM6IEltcG9ydCBwYXRjaCAic3RhZ2luZzog
d2Z4OiBtYWtlIGEgY29uc3QgYXJyYXkgc3RhdGljLCBtYWtlcwogICAgICBvYmplY3Qgc21hbGxl
ciIgKENvbGluKQoKdjE6CiAgLSBEcm9wIHRoZSBmdW5jdGlvbiBuYW1lIGluIHRoZSB3YXJuaW5n
IG1lc3NhZ2UgKEthbGxlKQogIC0gUmVwbGFjZSBnb3RvIGJ5IHJldHVybiBpbiB3Znhfc2VuZF9w
ZGF0YV9wZHMoKSAoS2FsbGUsIERhbikKICAtIEltcHJvdmUgZXJyb3IgbGFiZWwgaW4gd2Z4X3Nl
bmRfcGRhdGFfcGRzKCkgKEthbGxlKQoKSsOpcsO0bWUgUG91aWxsZXIgKDI0KToKICBtbWM6IHNk
aW86IGFkZCBTRElPIElEcyBmb3IgU2lsYWJzIFdGMjAwIGNoaXAKICBkdC1iaW5kaW5nczogaW50
cm9kdWNlIHNpbGFicyx3ZngueWFtbAogIHdmeDogYWRkIE1ha2VmaWxlL0tjb25maWcKICB3Zng6
IGFkZCB3ZnguaAogIHdmeDogYWRkIG1haW4uYy9tYWluLmgKICB3Zng6IGFkZCBidXMuaAogIHdm
eDogYWRkIGJ1c19zcGkuYwogIHdmeDogYWRkIGJ1c19zZGlvLmMKICB3Zng6IGFkZCBod2lvLmMv
aHdpby5oCiAgd2Z4OiBhZGQgZndpby5jL2Z3aW8uaAogIHdmeDogYWRkIGJoLmMvYmguaAogIHdm
eDogYWRkIGhpZl9hcGlfKi5oCiAgd2Z4OiBhZGQgaGlmX3R4Ki5jL2hpZl90eCouaAogIHdmeDog
YWRkIGtleS5jL2tleS5oCiAgd2Z4OiBhZGQgaGlmX3J4LmMvaGlmX3J4LmgKICB3Zng6IGFkZCBk
YXRhX3J4LmMvZGF0YV9yeC5oCiAgd2Z4OiBhZGQgcXVldWUuYy9xdWV1ZS5oCiAgd2Z4OiBhZGQg
ZGF0YV90eC5jL2RhdGFfdHguaAogIHdmeDogYWRkIHN0YS5jL3N0YS5oCiAgd2Z4OiBhZGQgc2Nh
bi5jL3NjYW4uaAogIHdmeDogYWRkIGRlYnVnLmMvZGVidWcuaAogIHdmeDogYWRkIHRyYWNlcy5o
CiAgd2Z4OiByZW1vdmUgZnJvbSB0aGUgc3RhZ2luZyBhcmVhCiAgd2Z4OiBnZXQgb3V0IGZyb20g
dGhlIHN0YWdpbmcgYXJlYQoKIC4uLi9iaW5kaW5ncy9uZXQvd2lyZWxlc3Mvc2lsYWJzLHdmeC55
YW1sICAgICB8ICA2NCArKy0tCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDMgKy0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL0tjb25maWcgICAgICAgICAg
ICAgICAgICB8ICAgMSArCiBkcml2ZXJzL25ldC93aXJlbGVzcy9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgfCAgIDEgKwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL0tjb25maWcgICAgICAg
ICAgIHwgIDE4ICsKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy9NYWtlZmlsZSAgICAgICAg
ICB8ICAgMyArCiAuLi4vd2lyZWxlc3Mvc2lsYWJzfS93ZngvS2NvbmZpZyAgICAgICAgICAgICAg
fCAgIDUgKwogLi4uL3dpcmVsZXNzL3NpbGFic30vd2Z4L01ha2VmaWxlICAgICAgICAgICAgIHwg
ICAzICstCiAuLi4ve3N0YWdpbmcgPT4gbmV0L3dpcmVsZXNzL3NpbGFic30vd2Z4L2JoLmMgfCAg
MzEgKy0KIC4uLi97c3RhZ2luZyA9PiBuZXQvd2lyZWxlc3Mvc2lsYWJzfS93ZngvYmguaCB8ICAg
MSArCiAuLi4vd2lyZWxlc3Mvc2lsYWJzfS93ZngvYnVzLmggICAgICAgICAgICAgICAgfCAgIDIg
Ky0KIC4uLi93aXJlbGVzcy9zaWxhYnN9L3dmeC9idXNfc2Rpby5jICAgICAgICAgICB8ICA5MSAr
KystLQogLi4uL3dpcmVsZXNzL3NpbGFic30vd2Z4L2J1c19zcGkuYyAgICAgICAgICAgIHwgIDY4
ICsrKy0KIC4uLi93aXJlbGVzcy9zaWxhYnN9L3dmeC9kYXRhX3J4LmMgICAgICAgICAgICB8ICAg
MiArLQogLi4uL3dpcmVsZXNzL3NpbGFic30vd2Z4L2RhdGFfcnguaCAgICAgICAgICAgIHwgICA0
ICstCiAuLi4vd2lyZWxlc3Mvc2lsYWJzfS93ZngvZGF0YV90eC5jICAgICAgICAgICAgfCAgODYg
KystLS0KIC4uLi93aXJlbGVzcy9zaWxhYnN9L3dmeC9kYXRhX3R4LmggICAgICAgICAgICB8ICAx
NCArLQogLi4uL3dpcmVsZXNzL3NpbGFic30vd2Z4L2RlYnVnLmMgICAgICAgICAgICAgIHwgIDQx
ICstLQogLi4uL3dpcmVsZXNzL3NpbGFic30vd2Z4L2RlYnVnLmggICAgICAgICAgICAgIHwgICA2
ICstCiAuLi4vd2lyZWxlc3Mvc2lsYWJzfS93ZngvZndpby5jICAgICAgICAgICAgICAgfCAgNzgg
KystLQogLi4uL3dpcmVsZXNzL3NpbGFic30vd2Z4L2Z3aW8uaCAgICAgICAgICAgICAgIHwgICAw
CiAuLi4vd2lyZWxlc3Mvc2lsYWJzfS93ZngvaGlmX2FwaV9jbWQuaCAgICAgICAgfCAxNDQgKysr
Ky0tLS0KIC4uLi93aXJlbGVzcy9zaWxhYnN9L3dmeC9oaWZfYXBpX2dlbmVyYWwuaCAgICB8ICA2
MCArKy0tCiAuLi4vd2lyZWxlc3Mvc2lsYWJzfS93ZngvaGlmX2FwaV9taWIuaCAgICAgICAgfCAg
NjggKystLQogLi4uL3dpcmVsZXNzL3NpbGFic30vd2Z4L2hpZl9yeC5jICAgICAgICAgICAgIHwg
MTQyICsrKystLS0tCiAuLi4vd2lyZWxlc3Mvc2lsYWJzfS93ZngvaGlmX3J4LmggICAgICAgICAg
ICAgfCAgIDAKIC4uLi93aXJlbGVzcy9zaWxhYnN9L3dmeC9oaWZfdHguYyAgICAgICAgICAgICB8
IDE1MiArKysrLS0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguaCAg
ICAgIHwgIDY0ICsrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3R4X21p
Yi5jICB8IDMzMyArKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFi
cy93ZngvaGlmX3R4X21pYi5oICB8ICA1NSArKysKIC4uLi93aXJlbGVzcy9zaWxhYnN9L3dmeC9o
d2lvLmMgICAgICAgICAgICAgICB8IDE1NiArKysrLS0tLQogLi4uL3dpcmVsZXNzL3NpbGFic30v
d2Z4L2h3aW8uaCAgICAgICAgICAgICAgIHwgIDM2ICstCiAuLi4vd2lyZWxlc3Mvc2lsYWJzfS93
Zngva2V5LmMgICAgICAgICAgICAgICAgfCAgMjQgKy0KIC4uLi93aXJlbGVzcy9zaWxhYnN9L3dm
eC9rZXkuaCAgICAgICAgICAgICAgICB8ICAgMAogLi4uL3dpcmVsZXNzL3NpbGFic30vd2Z4L21h
aW4uYyAgICAgICAgICAgICAgIHwgIDU4ICsrLQogLi4uL3dpcmVsZXNzL3NpbGFic30vd2Z4L21h
aW4uaCAgICAgICAgICAgICAgIHwgICA1ICstCiAuLi4vd2lyZWxlc3Mvc2lsYWJzfS93ZngvcXVl
dWUuYyAgICAgICAgICAgICAgfCAgMjIgKy0KIC4uLi93aXJlbGVzcy9zaWxhYnN9L3dmeC9xdWV1
ZS5oICAgICAgICAgICAgICB8ICAgMiArLQogLi4uL3dpcmVsZXNzL3NpbGFic30vd2Z4L3NjYW4u
YyAgICAgICAgICAgICAgIHwgIDE5ICstCiAuLi4vd2lyZWxlc3Mvc2lsYWJzfS93Zngvc2Nhbi5o
ICAgICAgICAgICAgICAgfCAgIDAKIC4uLi93aXJlbGVzcy9zaWxhYnN9L3dmeC9zdGEuYyAgICAg
ICAgICAgICAgICB8IDExMSArKystLS0KIC4uLi93aXJlbGVzcy9zaWxhYnN9L3dmeC9zdGEuaCAg
ICAgICAgICAgICAgICB8ICAgMAogLi4uL3dpcmVsZXNzL3NpbGFic30vd2Z4L3RyYWNlcy5oICAg
ICAgICAgICAgIHwgIDEwICstCiAuLi4vd2lyZWxlc3Mvc2lsYWJzfS93Zngvd2Z4LmggICAgICAg
ICAgICAgICAgfCAgMTMgKy0KIGRyaXZlcnMvc3RhZ2luZy9LY29uZmlnICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMSAtCiBkcml2ZXJzL3N0YWdpbmcvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDEgLQogZHJpdmVycy9zdGFnaW5nL3dmeC9UT0RPICAgICAgICAgICAgICAgICAg
ICAgIHwgICA2IC0KIGRyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3R4LmggICAgICAgICAgICAgICAg
ICB8ICA2MCAtLS0tCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl90eF9taWIuYyAgICAgICAgICAg
ICAgfCAzMjQgLS0tLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3R4X21p
Yi5oICAgICAgICAgICAgICB8ICA0OSAtLS0KIGluY2x1ZGUvbGludXgvbW1jL3NkaW9faWRzLmgg
ICAgICAgICAgICAgICAgICB8ICAgNyArCiA1MSBmaWxlcyBjaGFuZ2VkLCAxMjYyIGluc2VydGlv
bnMoKyksIDExODIgZGVsZXRpb25zKC0pCiByZW5hbWUge2RyaXZlcnMvc3RhZ2luZy93ZngvRG9j
dW1lbnRhdGlvbiA9PiBEb2N1bWVudGF0aW9ufS9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJl
bGVzcy9zaWxhYnMsd2Z4LnlhbWwgKDY4JSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25l
dC93aXJlbGVzcy9zaWxhYnMvS2NvbmZpZwogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy9NYWtlZmlsZQogcmVuYW1lIGRyaXZlcnMve3N0YWdpbmcgPT4gbmV0
L3dpcmVsZXNzL3NpbGFic30vd2Z4L0tjb25maWcgKDYwJSkKIHJlbmFtZSBkcml2ZXJzL3tzdGFn
aW5nID0+IG5ldC93aXJlbGVzcy9zaWxhYnN9L3dmeC9NYWtlZmlsZSAoNzYlKQogcmVuYW1lIGRy
aXZlcnMve3N0YWdpbmcgPT4gbmV0L3dpcmVsZXNzL3NpbGFic30vd2Z4L2JoLmMgKDkwJSkKIHJl
bmFtZSBkcml2ZXJzL3tzdGFnaW5nID0+IG5ldC93aXJlbGVzcy9zaWxhYnN9L3dmeC9iaC5oICg5
NiUpCiByZW5hbWUgZHJpdmVycy97c3RhZ2luZyA9PiBuZXQvd2lyZWxlc3Mvc2lsYWJzfS93Zngv
YnVzLmggKDk3JSkKIHJlbmFtZSBkcml2ZXJzL3tzdGFnaW5nID0+IG5ldC93aXJlbGVzcy9zaWxh
YnN9L3dmeC9idXNfc2Rpby5jICg3MyUpCiByZW5hbWUgZHJpdmVycy97c3RhZ2luZyA9PiBuZXQv
d2lyZWxlc3Mvc2lsYWJzfS93ZngvYnVzX3NwaS5jICg3NyUpCiByZW5hbWUgZHJpdmVycy97c3Rh
Z2luZyA9PiBuZXQvd2lyZWxlc3Mvc2lsYWJzfS93ZngvZGF0YV9yeC5jICg5NyUpCiByZW5hbWUg
ZHJpdmVycy97c3RhZ2luZyA9PiBuZXQvd2lyZWxlc3Mvc2lsYWJzfS93ZngvZGF0YV9yeC5oICg3
NyUpCiByZW5hbWUgZHJpdmVycy97c3RhZ2luZyA9PiBuZXQvd2lyZWxlc3Mvc2lsYWJzfS93Zngv
ZGF0YV90eC5jICg4NyUpCiByZW5hbWUgZHJpdmVycy97c3RhZ2luZyA9PiBuZXQvd2lyZWxlc3Mv
c2lsYWJzfS93ZngvZGF0YV90eC5oICg3NiUpCiByZW5hbWUgZHJpdmVycy97c3RhZ2luZyA9PiBu
ZXQvd2lyZWxlc3Mvc2lsYWJzfS93ZngvZGVidWcuYyAoODklKQogcmVuYW1lIGRyaXZlcnMve3N0
YWdpbmcgPT4gbmV0L3dpcmVsZXNzL3NpbGFic30vd2Z4L2RlYnVnLmggKDY1JSkKIHJlbmFtZSBk
cml2ZXJzL3tzdGFnaW5nID0+IG5ldC93aXJlbGVzcy9zaWxhYnN9L3dmeC9md2lvLmMgKDgzJSkK
IHJlbmFtZSBkcml2ZXJzL3tzdGFnaW5nID0+IG5ldC93aXJlbGVzcy9zaWxhYnN9L3dmeC9md2lv
LmggKDEwMCUpCiByZW5hbWUgZHJpdmVycy97c3RhZ2luZyA9PiBuZXQvd2lyZWxlc3Mvc2lsYWJz
fS93ZngvaGlmX2FwaV9jbWQuaCAoODElKQogcmVuYW1lIGRyaXZlcnMve3N0YWdpbmcgPT4gbmV0
L3dpcmVsZXNzL3NpbGFic30vd2Z4L2hpZl9hcGlfZ2VuZXJhbC5oICg4OCUpCiByZW5hbWUgZHJp
dmVycy97c3RhZ2luZyA9PiBuZXQvd2lyZWxlc3Mvc2lsYWJzfS93ZngvaGlmX2FwaV9taWIuaCAo
ODYlKQogcmVuYW1lIGRyaXZlcnMve3N0YWdpbmcgPT4gbmV0L3dpcmVsZXNzL3NpbGFic30vd2Z4
L2hpZl9yeC5jICg2OSUpCiByZW5hbWUgZHJpdmVycy97c3RhZ2luZyA9PiBuZXQvd2lyZWxlc3Mv
c2lsYWJzfS93ZngvaGlmX3J4LmggKDEwMCUpCiByZW5hbWUgZHJpdmVycy97c3RhZ2luZyA9PiBu
ZXQvd2lyZWxlc3Mvc2lsYWJzfS93ZngvaGlmX3R4LmMgKDcyJSkKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl90eC5oCiBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHhfbWliLmMKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl90eF9taWIu
aAogcmVuYW1lIGRyaXZlcnMve3N0YWdpbmcgPT4gbmV0L3dpcmVsZXNzL3NpbGFic30vd2Z4L2h3
aW8uYyAoNTElKQogcmVuYW1lIGRyaXZlcnMve3N0YWdpbmcgPT4gbmV0L3dpcmVsZXNzL3NpbGFi
c30vd2Z4L2h3aW8uaCAoNjIlKQogcmVuYW1lIGRyaXZlcnMve3N0YWdpbmcgPT4gbmV0L3dpcmVs
ZXNzL3NpbGFic30vd2Z4L2tleS5jICg5MCUpCiByZW5hbWUgZHJpdmVycy97c3RhZ2luZyA9PiBu
ZXQvd2lyZWxlc3Mvc2lsYWJzfS93Zngva2V5LmggKDEwMCUpCiByZW5hbWUgZHJpdmVycy97c3Rh
Z2luZyA9PiBuZXQvd2lyZWxlc3Mvc2lsYWJzfS93ZngvbWFpbi5jICg5MyUpCiByZW5hbWUgZHJp
dmVycy97c3RhZ2luZyA9PiBuZXQvd2lyZWxlc3Mvc2lsYWJzfS93ZngvbWFpbi5oICg5MiUpCiBy
ZW5hbWUgZHJpdmVycy97c3RhZ2luZyA9PiBuZXQvd2lyZWxlc3Mvc2lsYWJzfS93ZngvcXVldWUu
YyAoOTUlKQogcmVuYW1lIGRyaXZlcnMve3N0YWdpbmcgPT4gbmV0L3dpcmVsZXNzL3NpbGFic30v
d2Z4L3F1ZXVlLmggKDk1JSkKIHJlbmFtZSBkcml2ZXJzL3tzdGFnaW5nID0+IG5ldC93aXJlbGVz
cy9zaWxhYnN9L3dmeC9zY2FuLmMgKDg4JSkKIHJlbmFtZSBkcml2ZXJzL3tzdGFnaW5nID0+IG5l
dC93aXJlbGVzcy9zaWxhYnN9L3dmeC9zY2FuLmggKDEwMCUpCiByZW5hbWUgZHJpdmVycy97c3Rh
Z2luZyA9PiBuZXQvd2lyZWxlc3Mvc2lsYWJzfS93Zngvc3RhLmMgKDg4JSkKIHJlbmFtZSBkcml2
ZXJzL3tzdGFnaW5nID0+IG5ldC93aXJlbGVzcy9zaWxhYnN9L3dmeC9zdGEuaCAoMTAwJSkKIHJl
bmFtZSBkcml2ZXJzL3tzdGFnaW5nID0+IG5ldC93aXJlbGVzcy9zaWxhYnN9L3dmeC90cmFjZXMu
aCAoOTclKQogcmVuYW1lIGRyaXZlcnMve3N0YWdpbmcgPT4gbmV0L3dpcmVsZXNzL3NpbGFic30v
d2Z4L3dmeC5oICg5MyUpCiBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9U
T0RPCiBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfdHguaAogZGVs
ZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3R4X21pYi5jCiBkZWxldGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfdHhfbWliLmgKCi0tIAoyLjMzLjAK
Cg==
