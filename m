Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ECF40FBB3
	for <lists+linux-mmc@lfdr.de>; Fri, 17 Sep 2021 17:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344252AbhIQPR2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 17 Sep 2021 11:17:28 -0400
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:28225
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241419AbhIQPQ5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Sep 2021 11:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzuRgcJ6uJC5zZn89Dy30mZTM1N0odcrcHxWoup9HXq+3sSga1ZrlrKcsyOYAXopIQ74XkowTcEQWBj7k37mPRY8512CPCxHWpWP2meoLJvtiR5VvSaC15K4LWwk0+vXTkntN29QESHAwPuLC8mIGzXr8Je/QerU2sWWkI0yfGcIidVlvKCRJfA6G72+TvFtPmFVkyeuC7Ljxrg0s1v4Jiwhx378Y5705FYol6f5AcjnRgSv6Eow1fK5Np9bA7rt5LbB13SXLM3lVZRYWgHxv8z8uMTkOfURGHYZTZSpmdlmDdY9YTzmPGdB9e5/NorJlp2SBLpABKdpmyyPSkefJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BAezOkvJbcZwRz4eOVx5dT1/sgjmeA67Vtd9TVmp/Co=;
 b=PhFO1IpmJ6tsWrE5+eYtsA8y4ULJXOKszm2Dra35MuT6ZURyv2kDAAwjYn9FU5Qq+y1Bdz6aJSaVqw2Xi+RU1XR7RKFRx3pH58fHavkiyLWt9b9zMooG1sC2xcoAJ0I3lH7XBNH5hTYjkbvb41UVuJgfZB7TpWSaOlx8F8VwUXorg9CQ3WV7tI4+6pE8AdcSMgnnPaYGAaiy34ovaXyNzWY2Bhfy6M13/gtbUyOCRbAEahUYpI17RUsvt4VdzkraXiZmQEDQziA0fNf+V7Nd0RY0iYXtoiBRohCax/4uOD8ARtKpGd/Ud82v1BmDi2DIwp4W/2BJeOQX+NsDBt95Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAezOkvJbcZwRz4eOVx5dT1/sgjmeA67Vtd9TVmp/Co=;
 b=oaiwcQyiEA+6Te7v9FORdSXYM3345N1Z7Zi6shy5cQyikEx0rkrq/jD3HXR49EdzAa7OQDwwi4lwtJkRVNu4Rv7UcsUDKOSXzzMYt0NpsD3kR/b/sB2Y++oue8R20PVcicGptxEgGULg0URoAQjRdRIUdtJR6XMCPpvzPR/cnHA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 15:15:15 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd%7]) with mapi id 15.20.4500.017; Fri, 17 Sep 2021
 15:15:15 +0000
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
Subject: [PATCH v6 22/24] wfx: add traces.h
Date:   Fri, 17 Sep 2021 17:13:58 +0200
Message-Id: <20210917151401.2274772-23-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917151401.2274772-1-Jerome.Pouiller@silabs.com>
References: <20210917151401.2274772-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SA9PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:806:20::34) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
Received: from pc-42.silabs.com (2a01:e34:ecb5:66a0:9876:e1d7:65be:d294) by SA9PR03CA0029.namprd03.prod.outlook.com (2603:10b6:806:20::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 15:15:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d957b655-85a8-4612-5fe8-08d979edf34a
X-MS-TrafficTypeDiagnostic: SN6PR11MB3360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB336017B4BA071F8F65DF44D793DD9@SN6PR11MB3360.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:66;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16+SSs8apavO5Mmts+e2qq/PETphJ+74S1aw7lBJ4GuzAdb3Ae7Es9xdOFKElf1FBIfyCF708ZrcHrxZqgN2UEFfJFE9p0HRjKqwOaOs6kDZEGq74+eY/FQjwZjUdWyNK+wrtLYtEw5N3NKJUDTfRgw5oTQqRe/7P2lU6whc2Z+UZ/jntaZMplq+62dNQtacwehLVl15CG9Q6qN1RBzyFH6Qc3tWlUp8oaEiK8BIgDOu3e1eiM+gVB5j3459t4NZPIE2x+/rcVnnNVaTCacGSsBpXrq1yS+QJ4q6xr7CToDzvjXL/j8BL9YbzKH2WXtOHM0/V5QNWTUK/SLKQ6rGT/qZbnc+oKwCU7P9MTHuka9krf68cr5M/U6C+RSieXm33DR/MDiZt50ILTbgeyznEn9Ie2Xp3aaJx6PRvwC6PkQhiNh0dVSb4P9JVly0uFK7TGdaGatuGkaBu0Nqs8HbNwEOk8mSJYCDPjfS/jLf0LQv9z3cyOApeuCHhzITgqCa0LKPPzAs0lAdoDBy65HRjwgzcdwDgdwlJnLFz74yqwj7sD7bekARCCadt5pfnl0slRnIHq7bs9+wKnrs6dMZgDGT5tHKjxkctnH301gWOerJ0PxOYTGji6F/+2Mc7n9ZfEFN37cUnmMdv6OaJXqYWPvj7pK4uF8pv9gxWI7fnaKb/49vJTP5VvPO6wpRZVTt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(376002)(346002)(396003)(136003)(8936002)(5660300002)(36756003)(7696005)(86362001)(83380400001)(52116002)(54906003)(66476007)(107886003)(66556008)(30864003)(8676002)(66946007)(316002)(2616005)(7416002)(6916009)(4326008)(38100700002)(66574015)(6666004)(186003)(478600001)(6486002)(2906002)(1076003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFZGdlhNQ0UvWjJFUFhTMTZyUUdqNmwzY2Qza0JTa3hKRVMxSEVxZ0c1K0tk?=
 =?utf-8?B?Rm9PVG43U1dyVEwyZHRQS29OM1pzbktqQnBHSDdETFdLREJqNzBEUjZMQ2E0?=
 =?utf-8?B?MzdjK0diWW4xdDIyK2xqNWlHRE1zTEx5b0FaV3kwU2FGQUFhTFJsTDlWbTVX?=
 =?utf-8?B?dXA4bGQ0QzJMTyt4V1R3dW9rc0l6RVZyM2R6UUM3TUtPVDBCVDk0bmF2aGRq?=
 =?utf-8?B?eXFQNllCSHpnVDErV2tHSm1YRW9qVHBvK2FyaC9XbUkwZ3hFV3ZqTlNyajRl?=
 =?utf-8?B?SktYZEVaVWxsWmhTS3RJU3FXaHFMT08vSkw5b25QTFA0MmlCcUhjMWliL3Ro?=
 =?utf-8?B?cTRZa1daSXdmby9oOWxJWERaT2xXeFM0NG9mMXd6VnFMZm9MOEUxak5KeSt6?=
 =?utf-8?B?Y096TlhtcTYyMnY3N2Mwbys5ZTNudHJEdDNVRmVlczhOUnVRVWtXbStlc2VG?=
 =?utf-8?B?M2VGTjhmenBoZ2JsOU5aeDY4eXI5UFpoem42T3NVMjNSbmpnQjZUcVJaWDdQ?=
 =?utf-8?B?LzVSK3FkTEJSK2hnbEgyMEIySVlkSEUvOHdoOWgweHRLSWVJS1FjdW1uUUY5?=
 =?utf-8?B?U2trci9iRG9IRTMyTmpBTUhreUNGTiszWHc3N3lLTHZVbU85S0lURzFUdEx5?=
 =?utf-8?B?VWw5WUhhenZrUk5lY1dFZUlpMFZpNGEzU1o5d0VlbEUwb00yNHQzdXU4K2Fv?=
 =?utf-8?B?cnJnSWw3b0Z0QWJWR0lMRzdmOUZ3V0p4dzVYTk1RVC9KdTBXZW1CU3hYUVNo?=
 =?utf-8?B?NC9sNkozbEo4VTBHVnN6YXEwK1FzdXBGbE1WcmZ5M3dJUTltRHZUeGVGWDRk?=
 =?utf-8?B?blkxd252UjIzRWtDMzFhS3JHcENzQ2h2dVA0ZGpuMXg1b3VmVVB2VGZ5cnM2?=
 =?utf-8?B?WE9sSlg5L2psbkVtTWVjZ29xWUU2M3B6WGU4SUF3MkxIWWEwR29VY0RUUlR6?=
 =?utf-8?B?bW9nVmtTY01Xc0czQVFGY2pTT2lkSGc2RmxERlNvRWtpS3IrT1drZ1BzOFJp?=
 =?utf-8?B?SE11anp5cjZ4S0szellTY0FwWnZGT2dlMDRHMlBhV3pHdi9WcEhRVWNuMlhz?=
 =?utf-8?B?aHhLeXV5bUFqamViRHJybkVKUGMxaG1LVmpqVlpWQ1ViUzNDVzN1dENzcVNn?=
 =?utf-8?B?ZzAydWwvOWFwUmxZeitDb2pjNWlObmpmbHV1WGQ5SVBySUE1NTVJZEFrTTRP?=
 =?utf-8?B?YXlSRHprNnZHTnk1N0JWd1JGZDUybmptZE91UTh2eERHRlZLSHBWNVVCbDdS?=
 =?utf-8?B?amJOWjExQWdpSWU5MnU5MWFFSVQ5WVliK2J3TnV3T1pXd09naFFsOUNTU0Z5?=
 =?utf-8?B?dTZ2VXNKQmRtcm8wWnVXSlVDOVlDYmVwSVlvR1FaZW8vcDllN2Qvamp6alJp?=
 =?utf-8?B?QUJNZzhjck5ycndTM3ZweklaUWVrVXhzRU5rUVNlUUtmd3M4NG8vZ3M4RU83?=
 =?utf-8?B?SXFPZXU4S2dtYm9YUStsSUk2eWJMWThjYzRQeEZjTkh5Qm1ncUhIVFJSTXVt?=
 =?utf-8?B?TjV3UHZLN1hwVjE5RXZHQTlLblAxVC9UTzR5bk1LYjkzdGJNZzVMbDZxdTZj?=
 =?utf-8?B?S2R4QlFxTml0UVNUMHlHQ2JhNUlJbFhGZjVhejNVQ1hOR2RjNVRWNG5EQ3l3?=
 =?utf-8?B?TG9KbjQ2My9FaUR1cDgxb2M4Qm4vb2doSUoyUDY4VW0ySnJ0OUlNOGRSWWU4?=
 =?utf-8?B?Wm5PQW01Q0RidFVaaDlQMWpBdkZ0b2xJcm5iWU1GZkNNMFhQbDhQNkNDMTdL?=
 =?utf-8?B?b01RT2tKVW9YV2hrODd1SGtMUjRNNDZSenFvejVGejVWMzdud0J3aVErYStn?=
 =?utf-8?B?d3M3aFJGK3lGaDlORDlUaWtDT1d3ZWxmd2I4M0o5MW9kN2ovYzdWK2VSa3RC?=
 =?utf-8?Q?PXL2ZltcseoMm?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d957b655-85a8-4612-5fe8-08d979edf34a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 15:15:15.0630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZa+UymGH+TF+6CS9582M+XLvU/Dna0oLjdGff0bVSXbBH6OcZ4GDAPAmtnn2Q7YGtL2QYQ15uDkNoETs8f35A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3360
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvdHJhY2VzLmggfCA1MDEgKysr
KysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1MDEgaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvdHJhY2Vz
LmgKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3RyYWNlcy5o
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC90cmFjZXMuaApuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLmU5MGRjNzNjNGIwMQotLS0gL2Rldi9udWxsCisr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvdHJhY2VzLmgKQEAgLTAsMCArMSw1
MDEgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8KKy8qCisg
KiBUcmFjZXBvaW50cyBkZWZpbml0aW9ucy4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTgtMjAy
MCwgU2lsaWNvbiBMYWJvcmF0b3JpZXMsIEluYy4KKyAqLworCisjdW5kZWYgVFJBQ0VfU1lTVEVN
CisjZGVmaW5lIFRSQUNFX1NZU1RFTSB3ZngKKworI2lmICFkZWZpbmVkKF9XRlhfVFJBQ0VfSCkg
fHwgZGVmaW5lZChUUkFDRV9IRUFERVJfTVVMVElfUkVBRCkKKyNkZWZpbmUgX1dGWF9UUkFDRV9I
CisKKyNpbmNsdWRlIDxsaW51eC90cmFjZXBvaW50Lmg+CisjaW5jbHVkZSA8bmV0L21hYzgwMjEx
Lmg+CisKKyNpbmNsdWRlICJidXMuaCIKKyNpbmNsdWRlICJoaWZfYXBpX2NtZC5oIgorI2luY2x1
ZGUgImhpZl9hcGlfbWliLmgiCisKKy8qIFRoZSBoZWxsIGJlbG93IG5lZWQgc29tZSBleHBsYW5h
dGlvbnMuIEZvciBlYWNoIHN5bWJvbGljIG51bWJlciwgd2UgbmVlZCB0bworICogZGVmaW5lIGl0
IHdpdGggVFJBQ0VfREVGSU5FX0VOVU0oKSBhbmQgaW4gYSBsaXN0IGZvciBfX3ByaW50X3N5bWJv
bGljLgorICoKKyAqICAgMS4gRGVmaW5lIGEgbmV3IG1hY3JvIHRoYXQgY2FsbCBUUkFDRV9ERUZJ
TkVfRU5VTSgpOgorICoKKyAqICAgICAgICAgICNkZWZpbmUgeHh4X25hbWUoc3ltKSBUUkFDRV9E
RUZJTkVfRU5VTShzeW0pOworICoKKyAqICAgMi4gRGVmaW5lIGxpc3Qgb2YgYWxsIHN5bWJvbHM6
CisgKgorICogICAgICAgICAgI2RlZmluZSBsaXN0X25hbWVzICAgICBcCisgKiAgICAgICAgICAg
ICAuLi4gICAgICAgICAgICAgICAgIFwKKyAqICAgICAgICAgICAgIHh4eF9uYW1lKFhYWCkgICAg
ICAgXAorICogICAgICAgICAgICAgLi4uCisgKgorICogICAzLiBJbnN0YW50aWF0ZSB0aGF0IGxp
c3RfbmFtZXM6CisgKgorICogICAgICAgICAgbGlzdF9uYW1lcworICoKKyAqICAgNC4gUmVkZWZp
bmUgeHh4X25hbWUoKSBhcyBhbiBlbnRyeSBvZiBhcnJheSBmb3IgX19wcmludF9zeW1ib2xpYygp
CisgKgorICogICAgICAgICAgI3VuZGVmIHh4eF9uYW1lCisgKiAgICAgICAgICAjZGVmaW5lIHh4
eF9uYW1lKG1zZykgeyBtc2csICNtc2cgfSwKKyAqCisgKiAgIDUuIGxpc3RfbmFtZSBjYW4gbm93
IG5lYXJseSBiZSB1c2VkIHdpdGggX19wcmludF9zeW1ib2xpYygpIGJ1dCwKKyAqICAgICAgX19w
cmludF9zeW1ib2xpYygpIGRpc2xpa2UgbGFzdCBjb21tYSBvZiBsaXN0LiBTbyB3ZSBkZWZpbmUg
YSBuZXcgbGlzdAorICogICAgICB3aXRoIGEgZHVtbXkgZWxlbWVudDoKKyAqCisgKiAgICAgICAg
ICAjZGVmaW5lIGxpc3RfZm9yX3ByaW50X3N5bWJvbGljIGxpc3RfbmFtZXMgeyAtMSwgTlVMTCB9
CisgKi8KKworI2RlZmluZSBfaGlmX21zZ19saXN0ICAgICAgICAgICAgICAgICAgICAgICBcCisJ
aGlmX2NuZl9uYW1lKEFERF9LRVkpICAgICAgICAgICAgICAgXAorCWhpZl9jbmZfbmFtZShCRUFD
T05fVFJBTlNNSVQpICAgICAgIFwKKwloaWZfY25mX25hbWUoRURDQV9RVUVVRV9QQVJBTVMpICAg
ICBcCisJaGlmX2NuZl9uYW1lKEpPSU4pICAgICAgICAgICAgICAgICAgXAorCWhpZl9jbmZfbmFt
ZShNQVBfTElOSykgICAgICAgICAgICAgIFwKKwloaWZfY25mX25hbWUoUkVBRF9NSUIpICAgICAg
ICAgICAgICBcCisJaGlmX2NuZl9uYW1lKFJFTU9WRV9LRVkpICAgICAgICAgICAgXAorCWhpZl9j
bmZfbmFtZShSRVNFVCkgICAgICAgICAgICAgICAgIFwKKwloaWZfY25mX25hbWUoU0VUX0JTU19Q
QVJBTVMpICAgICAgICBcCisJaGlmX2NuZl9uYW1lKFNFVF9QTV9NT0RFKSAgICAgICAgICAgXAor
CWhpZl9jbmZfbmFtZShTVEFSVCkgICAgICAgICAgICAgICAgIFwKKwloaWZfY25mX25hbWUoU1RB
UlRfU0NBTikgICAgICAgICAgICBcCisJaGlmX2NuZl9uYW1lKFNUT1BfU0NBTikgICAgICAgICAg
ICAgXAorCWhpZl9jbmZfbmFtZShUWCkgICAgICAgICAgICAgICAgICAgIFwKKwloaWZfY25mX25h
bWUoTVVMVElfVFJBTlNNSVQpICAgICAgICBcCisJaGlmX2NuZl9uYW1lKFVQREFURV9JRSkgICAg
ICAgICAgICAgXAorCWhpZl9jbmZfbmFtZShXUklURV9NSUIpICAgICAgICAgICAgIFwKKwloaWZf
Y25mX25hbWUoQ09ORklHVVJBVElPTikgICAgICAgICBcCisJaGlmX2NuZl9uYW1lKENPTlRST0xf
R1BJTykgICAgICAgICAgXAorCWhpZl9jbmZfbmFtZShQUkVWRU5UX1JPTExCQUNLKSAgICAgIFwK
KwloaWZfY25mX25hbWUoU0VUX1NMX01BQ19LRVkpICAgICAgICBcCisJaGlmX2NuZl9uYW1lKFNM
X0NPTkZJR1VSRSkgICAgICAgICAgXAorCWhpZl9jbmZfbmFtZShTTF9FWENIQU5HRV9QVUJfS0VZ
UykgIFwKKwloaWZfY25mX25hbWUoU0hVVF9ET1dOKSAgICAgICAgICAgICBcCisJaGlmX2luZF9u
YW1lKEVWRU5UKSAgICAgICAgICAgICAgICAgXAorCWhpZl9pbmRfbmFtZShKT0lOX0NPTVBMRVRF
KSAgICAgICAgIFwKKwloaWZfaW5kX25hbWUoUlgpICAgICAgICAgICAgICAgICAgICBcCisJaGlm
X2luZF9uYW1lKFNDQU5fQ01QTCkgICAgICAgICAgICAgXAorCWhpZl9pbmRfbmFtZShTRVRfUE1f
TU9ERV9DTVBMKSAgICAgIFwKKwloaWZfaW5kX25hbWUoU1VTUEVORF9SRVNVTUVfVFgpICAgICBc
CisJaGlmX2luZF9uYW1lKFNMX0VYQ0hBTkdFX1BVQl9LRVlTKSAgXAorCWhpZl9pbmRfbmFtZShF
UlJPUikgICAgICAgICAgICAgICAgIFwKKwloaWZfaW5kX25hbWUoRVhDRVBUSU9OKSAgICAgICAg
ICAgICBcCisJaGlmX2luZF9uYW1lKEdFTkVSSUMpICAgICAgICAgICAgICAgXAorCWhpZl9pbmRf
bmFtZShXQUtFVVApICAgICAgICAgICAgICAgIFwKKwloaWZfaW5kX25hbWUoU1RBUlRVUCkKKwor
I2RlZmluZSBoaWZfbXNnX2xpc3RfZW51bSBfaGlmX21zZ19saXN0CisKKyN1bmRlZiBoaWZfY25m
X25hbWUKKyN1bmRlZiBoaWZfaW5kX25hbWUKKyNkZWZpbmUgaGlmX2NuZl9uYW1lKG1zZykgVFJB
Q0VfREVGSU5FX0VOVU0oSElGX0NORl9JRF8jI21zZyk7CisjZGVmaW5lIGhpZl9pbmRfbmFtZSht
c2cpIFRSQUNFX0RFRklORV9FTlVNKEhJRl9JTkRfSURfIyNtc2cpOworaGlmX21zZ19saXN0X2Vu
dW0KKyN1bmRlZiBoaWZfY25mX25hbWUKKyN1bmRlZiBoaWZfaW5kX25hbWUKKyNkZWZpbmUgaGlm
X2NuZl9uYW1lKG1zZykgeyBISUZfQ05GX0lEXyMjbXNnLCAjbXNnIH0sCisjZGVmaW5lIGhpZl9p
bmRfbmFtZShtc2cpIHsgSElGX0lORF9JRF8jI21zZywgI21zZyB9LAorI2RlZmluZSBoaWZfbXNn
X2xpc3QgaGlmX21zZ19saXN0X2VudW0geyAtMSwgTlVMTCB9CisKKyNkZWZpbmUgX2hpZl9taWJf
bGlzdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShBUlBf
SVBfQUREUkVTU0VTX1RBQkxFKSAgICAgICAgIFwKKwloaWZfbWliX25hbWUoQVJQX0tFRVBfQUxJ
VkVfUEVSSU9EKSAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKEJFQUNPTl9GSUxURVJfRU5BQkxF
KSAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShCRUFDT05fRklMVEVSX1RBQkxFKSAgICAgICAg
ICAgIFwKKwloaWZfbWliX25hbWUoQkVBQ09OX1NUQVRTKSAgICAgICAgICAgICAgICAgICBcCisJ
aGlmX21pYl9uYW1lKEJFQUNPTl9XQUtFVVBfUEVSSU9EKSAgICAgICAgICAgXAorCWhpZl9taWJf
bmFtZShCTE9DS19BQ0tfUE9MSUNZKSAgICAgICAgICAgICAgIFwKKwloaWZfbWliX25hbWUoQ0NB
X0NPTkZJRykgICAgICAgICAgICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKENPTkZJR19EQVRB
X0ZJTFRFUikgICAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShDT1VOVEVSU19UQUJMRSkgICAg
ICAgICAgICAgICAgIFwKKwloaWZfbWliX25hbWUoQ1VSUkVOVF9UWF9QT1dFUl9MRVZFTCkgICAg
ICAgICBcCisJaGlmX21pYl9uYW1lKERPVDExX01BQ19BRERSRVNTKSAgICAgICAgICAgICAgXAor
CWhpZl9taWJfbmFtZShET1QxMV9NQVhfUkVDRUlWRV9MSUZFVElNRSkgICAgIFwKKwloaWZfbWli
X25hbWUoRE9UMTFfTUFYX1RSQU5TTUlUX01TRFVfTElGRVRJTUUpIFwKKwloaWZfbWliX25hbWUo
RE9UMTFfUlRTX1RIUkVTSE9MRCkgICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKERPVDExX1dF
UF9ERUZBVUxUX0tFWV9JRCkgICAgICAgXAorCWhpZl9taWJfbmFtZShFVEhFUlRZUEVfREFUQUZS
QU1FX0NPTkRJVElPTikgIFwKKwloaWZfbWliX25hbWUoRVhURU5ERURfQ09VTlRFUlNfVEFCTEUp
ICAgICAgICBcCisJaGlmX21pYl9uYW1lKEdMX0JMT0NLX0FDS19JTkZPKSAgICAgICAgICAgICAg
XAorCWhpZl9taWJfbmFtZShHTF9PUEVSQVRJT05BTF9QT1dFUl9NT0RFKSAgICAgIFwKKwloaWZf
bWliX25hbWUoR0xfU0VUX01VTFRJX01TRykgICAgICAgICAgICAgICBcCisJaGlmX21pYl9uYW1l
KEdSUF9TRVFfQ09VTlRFUikgICAgICAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShJTkFDVElW
SVRZX1RJTUVSKSAgICAgICAgICAgICAgIFwKKwloaWZfbWliX25hbWUoSU5URVJGQUNFX1BST1RF
Q1RJT04pICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKElQVjRfQUREUl9EQVRBRlJBTUVfQ09O
RElUSU9OKSAgXAorCWhpZl9taWJfbmFtZShJUFY2X0FERFJfREFUQUZSQU1FX0NPTkRJVElPTikg
IFwKKwloaWZfbWliX25hbWUoS0VFUF9BTElWRV9QRVJJT0QpICAgICAgICAgICAgICBcCisJaGlm
X21pYl9uYW1lKE1BQ19BRERSX0RBVEFGUkFNRV9DT05ESVRJT04pICAgXAorCWhpZl9taWJfbmFt
ZShNQUdJQ19EQVRBRlJBTUVfQ09ORElUSU9OKSAgICAgIFwKKwloaWZfbWliX25hbWUoTUFYX1RY
X1BPV0VSX0xFVkVMKSAgICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKE5PTl9FUlBfUFJPVEVD
VElPTikgICAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShOU19JUF9BRERSRVNTRVNfVEFCTEUp
ICAgICAgICAgIFwKKwloaWZfbWliX25hbWUoT1ZFUlJJREVfSU5URVJOQUxfVFhfUkFURSkgICAg
ICBcCisJaGlmX21pYl9uYW1lKFBPUlRfREFUQUZSQU1FX0NPTkRJVElPTikgICAgICAgXAorCWhp
Zl9taWJfbmFtZShQUk9URUNURURfTUdNVF9QT0xJQ1kpICAgICAgICAgIFwKKwloaWZfbWliX25h
bWUoUkNQSV9SU1NJX1RIUkVTSE9MRCkgICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKFJYX0ZJ
TFRFUikgICAgICAgICAgICAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShTRVRfQVNTT0NJQVRJ
T05fTU9ERSkgICAgICAgICAgIFwKKwloaWZfbWliX25hbWUoU0VUX0RBVEFfRklMVEVSSU5HKSAg
ICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKFNFVF9IVF9QUk9URUNUSU9OKSAgICAgICAgICAg
ICAgXAorCWhpZl9taWJfbmFtZShTRVRfVFhfUkFURV9SRVRSWV9QT0xJQ1kpICAgICAgIFwKKwlo
aWZfbWliX25hbWUoU0VUX1VBUFNEX0lORk9STUFUSU9OKSAgICAgICAgICBcCisJaGlmX21pYl9u
YW1lKFNMT1RfVElNRSkgICAgICAgICAgICAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShTVEFU
SVNUSUNTX1RBQkxFKSAgICAgICAgICAgICAgIFwKKwloaWZfbWliX25hbWUoVEVNUExBVEVfRlJB
TUUpICAgICAgICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKFRTRl9DT1VOVEVSKSAgICAgICAg
ICAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShVQ19NQ19CQ19EQVRBRlJBTUVfQ09ORElUSU9O
KQorCisjZGVmaW5lIGhpZl9taWJfbGlzdF9lbnVtIF9oaWZfbWliX2xpc3QKKworI3VuZGVmIGhp
Zl9taWJfbmFtZQorI2RlZmluZSBoaWZfbWliX25hbWUobWliKSBUUkFDRV9ERUZJTkVfRU5VTShI
SUZfTUlCX0lEXyMjbWliKTsKK2hpZl9taWJfbGlzdF9lbnVtCisjdW5kZWYgaGlmX21pYl9uYW1l
CisjZGVmaW5lIGhpZl9taWJfbmFtZShtaWIpIHsgSElGX01JQl9JRF8jI21pYiwgI21pYiB9LAor
I2RlZmluZSBoaWZfbWliX2xpc3QgaGlmX21pYl9saXN0X2VudW0geyAtMSwgTlVMTCB9CisKK0RF
Q0xBUkVfRVZFTlRfQ0xBU1MoaGlmX2RhdGEsCisJVFBfUFJPVE8oY29uc3Qgc3RydWN0IGhpZl9t
c2cgKmhpZiwgaW50IHR4X2ZpbGxfbGV2ZWwsIGJvb2wgaXNfcmVjdiksCisJVFBfQVJHUyhoaWYs
IHR4X2ZpbGxfbGV2ZWwsIGlzX3JlY3YpLAorCVRQX1NUUlVDVF9fZW50cnkoCisJCV9fZmllbGQo
aW50LCB0eF9maWxsX2xldmVsKQorCQlfX2ZpZWxkKGludCwgbXNnX2lkKQorCQlfX2ZpZWxkKGNv
bnN0IGNoYXIgKiwgbXNnX3R5cGUpCisJCV9fZmllbGQoaW50LCBtc2dfbGVuKQorCQlfX2ZpZWxk
KGludCwgYnVmX2xlbikKKwkJX19maWVsZChpbnQsIGlmX2lkKQorCQlfX2ZpZWxkKGludCwgbWli
KQorCQlfX2FycmF5KHU4LCBidWYsIDEyOCkKKwkpLAorCVRQX2Zhc3RfYXNzaWduKAorCQlpbnQg
aGVhZGVyX2xlbjsKKworCQlfX2VudHJ5LT50eF9maWxsX2xldmVsID0gdHhfZmlsbF9sZXZlbDsK
KwkJX19lbnRyeS0+bXNnX2xlbiA9IGxlMTZfdG9fY3B1KGhpZi0+bGVuKTsKKwkJX19lbnRyeS0+
bXNnX2lkID0gaGlmLT5pZDsKKwkJX19lbnRyeS0+aWZfaWQgPSBoaWYtPmludGVyZmFjZTsKKwkJ
aWYgKGlzX3JlY3YpCisJCQlfX2VudHJ5LT5tc2dfdHlwZSA9IF9fZW50cnktPm1zZ19pZCAmIDB4
ODAgPyAiSU5EIiA6ICJDTkYiOworCQllbHNlCisJCQlfX2VudHJ5LT5tc2dfdHlwZSA9ICJSRVEi
OworCQlpZiAoIWlzX3JlY3YgJiYKKwkJICAgIChfX2VudHJ5LT5tc2dfaWQgPT0gSElGX1JFUV9J
RF9SRUFEX01JQiB8fAorCQkgICAgIF9fZW50cnktPm1zZ19pZCA9PSBISUZfUkVRX0lEX1dSSVRF
X01JQikpIHsKKwkJCV9fZW50cnktPm1pYiA9IGxlMTZfdG9fY3B1cCgoX19sZTE2ICopaGlmLT5i
b2R5KTsKKwkJCWhlYWRlcl9sZW4gPSA0OworCQl9IGVsc2UgeworCQkJX19lbnRyeS0+bWliID0g
LTE7CisJCQloZWFkZXJfbGVuID0gMDsKKwkJfQorCQlfX2VudHJ5LT5idWZfbGVuID0gbWluX3Qo
aW50LCBfX2VudHJ5LT5tc2dfbGVuLAorCQkJCQkgc2l6ZW9mKF9fZW50cnktPmJ1ZikpCisJCQkJ
ICAgLSBzaXplb2Yoc3RydWN0IGhpZl9tc2cpIC0gaGVhZGVyX2xlbjsKKwkJbWVtY3B5KF9fZW50
cnktPmJ1ZiwgaGlmLT5ib2R5ICsgaGVhZGVyX2xlbiwgX19lbnRyeS0+YnVmX2xlbik7CisJKSwK
KwlUUF9wcmludGsoIiVkOiVkOiVzXyVzJXMlczogJXMlcyAoJWQgYnl0ZXMpIiwKKwkJX19lbnRy
eS0+dHhfZmlsbF9sZXZlbCwKKwkJX19lbnRyeS0+aWZfaWQsCisJCV9fZW50cnktPm1zZ190eXBl
LAorCQlfX3ByaW50X3N5bWJvbGljKF9fZW50cnktPm1zZ19pZCwgaGlmX21zZ19saXN0KSwKKwkJ
X19lbnRyeS0+bWliICE9IC0xID8gIi8iIDogIiIsCisJCV9fZW50cnktPm1pYiAhPSAtMSA/IF9f
cHJpbnRfc3ltYm9saWMoX19lbnRyeS0+bWliLCBoaWZfbWliX2xpc3QpIDogIiIsCisJCV9fcHJp
bnRfaGV4KF9fZW50cnktPmJ1ZiwgX19lbnRyeS0+YnVmX2xlbiksCisJCV9fZW50cnktPm1zZ19s
ZW4gPiBzaXplb2YoX19lbnRyeS0+YnVmKSA/ICIgLi4uIiA6ICIiLAorCQlfX2VudHJ5LT5tc2df
bGVuCisJKQorKTsKK0RFRklORV9FVkVOVChoaWZfZGF0YSwgaGlmX3NlbmQsCisJVFBfUFJPVE8o
Y29uc3Qgc3RydWN0IGhpZl9tc2cgKmhpZiwgaW50IHR4X2ZpbGxfbGV2ZWwsIGJvb2wgaXNfcmVj
diksCisJVFBfQVJHUyhoaWYsIHR4X2ZpbGxfbGV2ZWwsIGlzX3JlY3YpKTsKKyNkZWZpbmUgX3Ry
YWNlX2hpZl9zZW5kKGhpZiwgdHhfZmlsbF9sZXZlbClcCisJdHJhY2VfaGlmX3NlbmQoaGlmLCB0
eF9maWxsX2xldmVsLCBmYWxzZSkKK0RFRklORV9FVkVOVChoaWZfZGF0YSwgaGlmX3JlY3YsCisJ
VFBfUFJPVE8oY29uc3Qgc3RydWN0IGhpZl9tc2cgKmhpZiwgaW50IHR4X2ZpbGxfbGV2ZWwsIGJv
b2wgaXNfcmVjdiksCisJVFBfQVJHUyhoaWYsIHR4X2ZpbGxfbGV2ZWwsIGlzX3JlY3YpKTsKKyNk
ZWZpbmUgX3RyYWNlX2hpZl9yZWN2KGhpZiwgdHhfZmlsbF9sZXZlbClcCisJdHJhY2VfaGlmX3Jl
Y3YoaGlmLCB0eF9maWxsX2xldmVsLCB0cnVlKQorCisjZGVmaW5lIHdmeF9yZWdfbGlzdF9lbnVt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVH
X0NPTkZJRywgICAgICAgIkNPTkZJRyIpICAgICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX0NP
TlRST0wsICAgICAgIkNPTlRST0wiKSAgICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX0lOX09V
VF9RVUVVRSwgIlFVRVVFIikgICAgICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX0FIQl9EUE9S
VCwgICAgIkFIQiIpICAgICAgICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX0JBU0VfQUREUiwg
ICAgIkJBU0VfQUREUiIpICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX1NSQU1fRFBPUlQsICAg
IlNSQU0iKSAgICAgICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX1NFVF9HRU5fUl9XLCAgIlNF
VF9HRU5fUl9XIikgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX0ZSQU1FX09VVCwgICAgIkZSQU1F
X09VVCIpCisKKyN1bmRlZiB3ZnhfcmVnX25hbWUKKyNkZWZpbmUgd2Z4X3JlZ19uYW1lKHN5bSwg
bmFtZSkgVFJBQ0VfREVGSU5FX0VOVU0oc3ltKTsKK3dmeF9yZWdfbGlzdF9lbnVtCisjdW5kZWYg
d2Z4X3JlZ19uYW1lCisjZGVmaW5lIHdmeF9yZWdfbmFtZShzeW0sIG5hbWUpIHsgc3ltLCBuYW1l
IH0sCisjZGVmaW5lIHdmeF9yZWdfbGlzdCB3ZnhfcmVnX2xpc3RfZW51bSB7IC0xLCBOVUxMIH0K
KworREVDTEFSRV9FVkVOVF9DTEFTUyhpb19kYXRhLAorCVRQX1BST1RPKGludCByZWcsIGludCBh
ZGRyLCBjb25zdCB2b2lkICppb19idWYsIHNpemVfdCBsZW4pLAorCVRQX0FSR1MocmVnLCBhZGRy
LCBpb19idWYsIGxlbiksCisJVFBfU1RSVUNUX19lbnRyeSgKKwkJX19maWVsZChpbnQsIHJlZykK
KwkJX19maWVsZChpbnQsIGFkZHIpCisJCV9fZmllbGQoaW50LCBtc2dfbGVuKQorCQlfX2ZpZWxk
KGludCwgYnVmX2xlbikKKwkJX19hcnJheSh1OCwgYnVmLCAzMikKKwkJX19hcnJheSh1OCwgYWRk
cl9zdHIsIDEwKQorCSksCisJVFBfZmFzdF9hc3NpZ24oCisJCV9fZW50cnktPnJlZyA9IHJlZzsK
KwkJX19lbnRyeS0+YWRkciA9IGFkZHI7CisJCV9fZW50cnktPm1zZ19sZW4gPSBsZW47CisJCV9f
ZW50cnktPmJ1Zl9sZW4gPSBtaW5fdChpbnQsIHNpemVvZihfX2VudHJ5LT5idWYpLAorCQkJCQkg
X19lbnRyeS0+bXNnX2xlbik7CisJCW1lbWNweShfX2VudHJ5LT5idWYsIGlvX2J1ZiwgX19lbnRy
eS0+YnVmX2xlbik7CisJCWlmIChhZGRyID49IDApCisJCQlzbnByaW50ZihfX2VudHJ5LT5hZGRy
X3N0ciwgMTAsICIvJTA4eCIsIGFkZHIpOworCQllbHNlCisJCQlfX2VudHJ5LT5hZGRyX3N0clsw
XSA9IDA7CisJKSwKKwlUUF9wcmludGsoIiVzJXM6ICVzJXMgKCVkIGJ5dGVzKSIsCisJCV9fcHJp
bnRfc3ltYm9saWMoX19lbnRyeS0+cmVnLCB3ZnhfcmVnX2xpc3QpLAorCQlfX2VudHJ5LT5hZGRy
X3N0ciwKKwkJX19wcmludF9oZXgoX19lbnRyeS0+YnVmLCBfX2VudHJ5LT5idWZfbGVuKSwKKwkJ
X19lbnRyeS0+bXNnX2xlbiA+IHNpemVvZihfX2VudHJ5LT5idWYpID8gIiAuLi4iIDogIiIsCisJ
CV9fZW50cnktPm1zZ19sZW4KKwkpCispOworREVGSU5FX0VWRU5UKGlvX2RhdGEsIGlvX3dyaXRl
LAorCVRQX1BST1RPKGludCByZWcsIGludCBhZGRyLCBjb25zdCB2b2lkICppb19idWYsIHNpemVf
dCBsZW4pLAorCVRQX0FSR1MocmVnLCBhZGRyLCBpb19idWYsIGxlbikpOworI2RlZmluZSBfdHJh
Y2VfaW9faW5kX3dyaXRlKHJlZywgYWRkciwgaW9fYnVmLCBsZW4pXAorCXRyYWNlX2lvX3dyaXRl
KHJlZywgYWRkciwgaW9fYnVmLCBsZW4pCisjZGVmaW5lIF90cmFjZV9pb193cml0ZShyZWcsIGlv
X2J1ZiwgbGVuKSB0cmFjZV9pb193cml0ZShyZWcsIC0xLCBpb19idWYsIGxlbikKK0RFRklORV9F
VkVOVChpb19kYXRhLCBpb19yZWFkLAorCVRQX1BST1RPKGludCByZWcsIGludCBhZGRyLCBjb25z
dCB2b2lkICppb19idWYsIHNpemVfdCBsZW4pLAorCVRQX0FSR1MocmVnLCBhZGRyLCBpb19idWYs
IGxlbikpOworI2RlZmluZSBfdHJhY2VfaW9faW5kX3JlYWQocmVnLCBhZGRyLCBpb19idWYsIGxl
bilcCisJdHJhY2VfaW9fcmVhZChyZWcsIGFkZHIsIGlvX2J1ZiwgbGVuKQorI2RlZmluZSBfdHJh
Y2VfaW9fcmVhZChyZWcsIGlvX2J1ZiwgbGVuKSB0cmFjZV9pb19yZWFkKHJlZywgLTEsIGlvX2J1
ZiwgbGVuKQorCitERUNMQVJFX0VWRU5UX0NMQVNTKGlvX2RhdGEzMiwKKwlUUF9QUk9UTyhpbnQg
cmVnLCBpbnQgYWRkciwgdTMyIHZhbCksCisJVFBfQVJHUyhyZWcsIGFkZHIsIHZhbCksCisJVFBf
U1RSVUNUX19lbnRyeSgKKwkJX19maWVsZChpbnQsIHJlZykKKwkJX19maWVsZChpbnQsIGFkZHIp
CisJCV9fZmllbGQoaW50LCB2YWwpCisJCV9fYXJyYXkodTgsIGFkZHJfc3RyLCAxMCkKKwkpLAor
CVRQX2Zhc3RfYXNzaWduKAorCQlfX2VudHJ5LT5yZWcgPSByZWc7CisJCV9fZW50cnktPmFkZHIg
PSBhZGRyOworCQlfX2VudHJ5LT52YWwgPSB2YWw7CisJCWlmIChhZGRyID49IDApCisJCQlzbnBy
aW50ZihfX2VudHJ5LT5hZGRyX3N0ciwgMTAsICIvJTA4eCIsIGFkZHIpOworCQllbHNlCisJCQlf
X2VudHJ5LT5hZGRyX3N0clswXSA9IDA7CisJKSwKKwlUUF9wcmludGsoIiVzJXM6ICUwOHgiLAor
CQlfX3ByaW50X3N5bWJvbGljKF9fZW50cnktPnJlZywgd2Z4X3JlZ19saXN0KSwKKwkJX19lbnRy
eS0+YWRkcl9zdHIsCisJCV9fZW50cnktPnZhbAorCSkKKyk7CitERUZJTkVfRVZFTlQoaW9fZGF0
YTMyLCBpb193cml0ZTMyLAorCVRQX1BST1RPKGludCByZWcsIGludCBhZGRyLCB1MzIgdmFsKSwK
KwlUUF9BUkdTKHJlZywgYWRkciwgdmFsKSk7CisjZGVmaW5lIF90cmFjZV9pb19pbmRfd3JpdGUz
MihyZWcsIGFkZHIsIHZhbCkgdHJhY2VfaW9fd3JpdGUzMihyZWcsIGFkZHIsIHZhbCkKKyNkZWZp
bmUgX3RyYWNlX2lvX3dyaXRlMzIocmVnLCB2YWwpIHRyYWNlX2lvX3dyaXRlMzIocmVnLCAtMSwg
dmFsKQorREVGSU5FX0VWRU5UKGlvX2RhdGEzMiwgaW9fcmVhZDMyLAorCVRQX1BST1RPKGludCBy
ZWcsIGludCBhZGRyLCB1MzIgdmFsKSwKKwlUUF9BUkdTKHJlZywgYWRkciwgdmFsKSk7CisjZGVm
aW5lIF90cmFjZV9pb19pbmRfcmVhZDMyKHJlZywgYWRkciwgdmFsKSB0cmFjZV9pb19yZWFkMzIo
cmVnLCBhZGRyLCB2YWwpCisjZGVmaW5lIF90cmFjZV9pb19yZWFkMzIocmVnLCB2YWwpIHRyYWNl
X2lvX3JlYWQzMihyZWcsIC0xLCB2YWwpCisKK0RFQ0xBUkVfRVZFTlRfQ0xBU1MocGlnZ3liYWNr
LAorCVRQX1BST1RPKHUzMiB2YWwsIGJvb2wgaWdub3JlZCksCisJVFBfQVJHUyh2YWwsIGlnbm9y
ZWQpLAorCVRQX1NUUlVDVF9fZW50cnkoCisJCV9fZmllbGQoaW50LCB2YWwpCisJCV9fZmllbGQo
Ym9vbCwgaWdub3JlZCkKKwkpLAorCVRQX2Zhc3RfYXNzaWduKAorCQlfX2VudHJ5LT52YWwgPSB2
YWw7CisJCV9fZW50cnktPmlnbm9yZWQgPSBpZ25vcmVkOworCSksCisJVFBfcHJpbnRrKCJDT05U
Uk9MOiAlMDh4JXMiLAorCQlfX2VudHJ5LT52YWwsCisJCV9fZW50cnktPmlnbm9yZWQgPyAiIChp
Z25vcmVkKSIgOiAiIgorCSkKKyk7CitERUZJTkVfRVZFTlQocGlnZ3liYWNrLCBwaWdneWJhY2ss
CisJVFBfUFJPVE8odTMyIHZhbCwgYm9vbCBpZ25vcmVkKSwKKwlUUF9BUkdTKHZhbCwgaWdub3Jl
ZCkpOworI2RlZmluZSBfdHJhY2VfcGlnZ3liYWNrKHZhbCwgaWdub3JlZCkgdHJhY2VfcGlnZ3li
YWNrKHZhbCwgaWdub3JlZCkKKworVFJBQ0VfRVZFTlQoYmhfc3RhdHMsCisJVFBfUFJPVE8oaW50
IGluZCwgaW50IHJlcSwgaW50IGNuZiwgaW50IGJ1c3ksIGJvb2wgcmVsZWFzZSksCisJVFBfQVJH
UyhpbmQsIHJlcSwgY25mLCBidXN5LCByZWxlYXNlKSwKKwlUUF9TVFJVQ1RfX2VudHJ5KAorCQlf
X2ZpZWxkKGludCwgaW5kKQorCQlfX2ZpZWxkKGludCwgcmVxKQorCQlfX2ZpZWxkKGludCwgY25m
KQorCQlfX2ZpZWxkKGludCwgYnVzeSkKKwkJX19maWVsZChib29sLCByZWxlYXNlKQorCSksCisJ
VFBfZmFzdF9hc3NpZ24oCisJCV9fZW50cnktPmluZCA9IGluZDsKKwkJX19lbnRyeS0+cmVxID0g
cmVxOworCQlfX2VudHJ5LT5jbmYgPSBjbmY7CisJCV9fZW50cnktPmJ1c3kgPSBidXN5OworCQlf
X2VudHJ5LT5yZWxlYXNlID0gcmVsZWFzZTsKKwkpLAorCVRQX3ByaW50aygiSU5EL1JFUS9DTkY6
JTNkLyUzZC8lM2QsIFJFUSBpbiBwcm9ncmVzczolM2QsIFdVUDogJXMiLAorCQlfX2VudHJ5LT5p
bmQsCisJCV9fZW50cnktPnJlcSwKKwkJX19lbnRyeS0+Y25mLAorCQlfX2VudHJ5LT5idXN5LAor
CQlfX2VudHJ5LT5yZWxlYXNlID8gInJlbGVhc2UiIDogImtlZXAiCisJKQorKTsKKyNkZWZpbmUg
X3RyYWNlX2JoX3N0YXRzKGluZCwgcmVxLCBjbmYsIGJ1c3ksIHJlbGVhc2UpXAorCXRyYWNlX2Jo
X3N0YXRzKGluZCwgcmVxLCBjbmYsIGJ1c3ksIHJlbGVhc2UpCisKK1RSQUNFX0VWRU5UKHR4X3N0
YXRzLAorCVRQX1BST1RPKGNvbnN0IHN0cnVjdCBoaWZfY25mX3R4ICp0eF9jbmYsIGNvbnN0IHN0
cnVjdCBza19idWZmICpza2IsCisJCSBpbnQgZGVsYXkpLAorCVRQX0FSR1ModHhfY25mLCBza2Is
IGRlbGF5KSwKKwlUUF9TVFJVQ1RfX2VudHJ5KAorCQlfX2ZpZWxkKGludCwgcGt0X2lkKQorCQlf
X2ZpZWxkKGludCwgZGVsYXlfbWVkaWEpCisJCV9fZmllbGQoaW50LCBkZWxheV9xdWV1ZSkKKwkJ
X19maWVsZChpbnQsIGRlbGF5X2Z3KQorCQlfX2ZpZWxkKGludCwgYWNrX2ZhaWx1cmVzKQorCQlf
X2ZpZWxkKGludCwgZmxhZ3MpCisJCV9fYXJyYXkoaW50LCByYXRlLCA0KQorCQlfX2FycmF5KGlu
dCwgdHhfY291bnQsIDQpCisJKSwKKwlUUF9mYXN0X2Fzc2lnbigKKwkJLyogS2VlcCBzeW5jIHdp
dGggd2Z4X3JhdGVzIGRlZmluaXRpb24gaW4gbWFpbi5jICovCisJCXN0YXRpYyBjb25zdCBpbnQg
aHdfcmF0ZVtdID0geyAwLCAxLCAyLCAzLCA2LCA3LCA4LCA5LAorCQkJCQkgICAgICAgMTAsIDEx
LCAxMiwgMTMgfTsKKwkJY29uc3Qgc3RydWN0IGllZWU4MDIxMV90eF9pbmZvICp0eF9pbmZvID0K
KwkJCShjb25zdCBzdHJ1Y3QgaWVlZTgwMjExX3R4X2luZm8gKilza2ItPmNiOworCQljb25zdCBz
dHJ1Y3QgaWVlZTgwMjExX3R4X3JhdGUgKnJhdGVzID0gdHhfaW5mby0+ZHJpdmVyX3JhdGVzOwor
CQlpbnQgaTsKKworCQlfX2VudHJ5LT5wa3RfaWQgPSB0eF9jbmYtPnBhY2tldF9pZDsKKwkJX19l
bnRyeS0+ZGVsYXlfbWVkaWEgPSBsZTMyX3RvX2NwdSh0eF9jbmYtPm1lZGlhX2RlbGF5KTsKKwkJ
X19lbnRyeS0+ZGVsYXlfcXVldWUgPSBsZTMyX3RvX2NwdSh0eF9jbmYtPnR4X3F1ZXVlX2RlbGF5
KTsKKwkJX19lbnRyeS0+ZGVsYXlfZncgPSBkZWxheTsKKwkJX19lbnRyeS0+YWNrX2ZhaWx1cmVz
ID0gdHhfY25mLT5hY2tfZmFpbHVyZXM7CisJCWlmICghdHhfY25mLT5zdGF0dXMgfHwgX19lbnRy
eS0+YWNrX2ZhaWx1cmVzKQorCQkJX19lbnRyeS0+YWNrX2ZhaWx1cmVzICs9IDE7CisKKwkJZm9y
IChpID0gMDsgaSA8IElFRUU4MDIxMV9OVU1fQUNTOyBpKyspIHsKKwkJCWlmIChyYXRlc1swXS5m
bGFncyAmIElFRUU4MDIxMV9UWF9SQ19NQ1MpCisJCQkJX19lbnRyeS0+cmF0ZVtpXSA9IHJhdGVz
W2ldLmlkeDsKKwkJCWVsc2UKKwkJCQlfX2VudHJ5LT5yYXRlW2ldID0gaHdfcmF0ZVtyYXRlc1tp
XS5pZHhdOworCQkJX19lbnRyeS0+dHhfY291bnRbaV0gPSByYXRlc1tpXS5jb3VudDsKKwkJfQor
CQlfX2VudHJ5LT5mbGFncyA9IDA7CisJCWlmIChyYXRlc1swXS5mbGFncyAmIElFRUU4MDIxMV9U
WF9SQ19NQ1MpCisJCQlfX2VudHJ5LT5mbGFncyB8PSAweDAxOworCQlpZiAocmF0ZXNbMF0uZmxh
Z3MgJiBJRUVFODAyMTFfVFhfUkNfU0hPUlRfR0kpCisJCQlfX2VudHJ5LT5mbGFncyB8PSAweDAy
OworCQlpZiAocmF0ZXNbMF0uZmxhZ3MgJiBJRUVFODAyMTFfVFhfUkNfR1JFRU5fRklFTEQpCisJ
CQlfX2VudHJ5LT5mbGFncyB8PSAweDA0OworCQlpZiAocmF0ZXNbMF0uZmxhZ3MgJiBJRUVFODAy
MTFfVFhfUkNfVVNFX1JUU19DVFMpCisJCQlfX2VudHJ5LT5mbGFncyB8PSAweDA4OworCQlpZiAo
dHhfaW5mby0+ZmxhZ3MgJiBJRUVFODAyMTFfVFhfQ1RMX1NFTkRfQUZURVJfRFRJTSkKKwkJCV9f
ZW50cnktPmZsYWdzIHw9IDB4MTA7CisJCWlmICh0eF9jbmYtPnN0YXR1cykKKwkJCV9fZW50cnkt
PmZsYWdzIHw9IDB4MjA7CisJCWlmICh0eF9jbmYtPnN0YXR1cyA9PSBISUZfU1RBVFVTX1RYX0ZB
SUxfUkVRVUVVRSkKKwkJCV9fZW50cnktPmZsYWdzIHw9IDB4NDA7CisJKSwKKwlUUF9wcmludGso
InBhY2tldCBJRDogJTA4eCwgcmF0ZSBwb2xpY3k6ICVzICVkfCVkICVkfCVkICVkfCVkICVkfCVk
IC0+ICVkIGF0dGVtcHQsIERlbGF5cyBtZWRpYS9xdWV1ZS90b3RhbDogJTRkdXMvJTRkdXMvJTRk
dXMiLAorCQlfX2VudHJ5LT5wa3RfaWQsCisJCV9fcHJpbnRfZmxhZ3MoX19lbnRyeS0+ZmxhZ3Ms
IE5VTEwsCisJCQl7IDB4MDEsICJNIiB9LCB7IDB4MDIsICJTIiB9LCB7IDB4MDQsICJHIiB9LAor
CQkJeyAweDA4LCAiUiIgfSwgeyAweDEwLCAiRCIgfSwgeyAweDIwLCAiRiIgfSwKKwkJCXsgMHg0
MCwgIlEiIH0pLAorCQlfX2VudHJ5LT5yYXRlWzBdLAorCQlfX2VudHJ5LT50eF9jb3VudFswXSwK
KwkJX19lbnRyeS0+cmF0ZVsxXSwKKwkJX19lbnRyeS0+dHhfY291bnRbMV0sCisJCV9fZW50cnkt
PnJhdGVbMl0sCisJCV9fZW50cnktPnR4X2NvdW50WzJdLAorCQlfX2VudHJ5LT5yYXRlWzNdLAor
CQlfX2VudHJ5LT50eF9jb3VudFszXSwKKwkJX19lbnRyeS0+YWNrX2ZhaWx1cmVzLAorCQlfX2Vu
dHJ5LT5kZWxheV9tZWRpYSwKKwkJX19lbnRyeS0+ZGVsYXlfcXVldWUsCisJCV9fZW50cnktPmRl
bGF5X2Z3CisJKQorKTsKKyNkZWZpbmUgX3RyYWNlX3R4X3N0YXRzKHR4X2NuZiwgc2tiLCBkZWxh
eSkgdHJhY2VfdHhfc3RhdHModHhfY25mLCBza2IsIGRlbGF5KQorCitUUkFDRV9FVkVOVChxdWV1
ZXNfc3RhdHMsCisJVFBfUFJPVE8oc3RydWN0IHdmeF9kZXYgKndkZXYsIGNvbnN0IHN0cnVjdCB3
ZnhfcXVldWUgKmVsZWN0ZWRfcXVldWUpLAorCVRQX0FSR1Mod2RldiwgZWxlY3RlZF9xdWV1ZSks
CisJVFBfU1RSVUNUX19lbnRyeSgKKwkJX19maWVsZChpbnQsIHZpZl9pZCkKKwkJX19maWVsZChp
bnQsIHF1ZXVlX2lkKQorCQlfX2FycmF5KGludCwgaHcsIElFRUU4MDIxMV9OVU1fQUNTICogMikK
KwkJX19hcnJheShpbnQsIGRydiwgSUVFRTgwMjExX05VTV9BQ1MgKiAyKQorCQlfX2FycmF5KGlu
dCwgY2FiLCBJRUVFODAyMTFfTlVNX0FDUyAqIDIpCisJKSwKKwlUUF9mYXN0X2Fzc2lnbigKKwkJ
Y29uc3Qgc3RydWN0IHdmeF9xdWV1ZSAqcXVldWU7CisJCXN0cnVjdCB3ZnhfdmlmICp3dmlmOwor
CQlpbnQgaSwgajsKKworCQlmb3IgKGogPSAwOyBqIDwgSUVFRTgwMjExX05VTV9BQ1MgKiAyOyBq
KyspIHsKKwkJCV9fZW50cnktPmh3W2pdID0gLTE7CisJCQlfX2VudHJ5LT5kcnZbal0gPSAtMTsK
KwkJCV9fZW50cnktPmNhYltqXSA9IC0xOworCQl9CisJCV9fZW50cnktPnZpZl9pZCA9IC0xOwor
CQlfX2VudHJ5LT5xdWV1ZV9pZCA9IC0xOworCQl3dmlmID0gTlVMTDsKKwkJd2hpbGUgKCh3dmlm
ID0gd3ZpZl9pdGVyYXRlKHdkZXYsIHd2aWYpKSAhPSBOVUxMKSB7CisJCQlmb3IgKGkgPSAwOyBp
IDwgSUVFRTgwMjExX05VTV9BQ1M7IGkrKykgeworCQkJCWogPSB3dmlmLT5pZCAqIElFRUU4MDIx
MV9OVU1fQUNTICsgaTsKKwkJCQlXQVJOX09OKGogPj0gSUVFRTgwMjExX05VTV9BQ1MgKiAyKTsK
KwkJCQlxdWV1ZSA9ICZ3dmlmLT50eF9xdWV1ZVtpXTsKKwkJCQlfX2VudHJ5LT5od1tqXSA9IGF0
b21pY19yZWFkKCZxdWV1ZS0+cGVuZGluZ19mcmFtZXMpOworCQkJCV9fZW50cnktPmRydltqXSA9
IHNrYl9xdWV1ZV9sZW4oJnF1ZXVlLT5ub3JtYWwpOworCQkJCV9fZW50cnktPmNhYltqXSA9IHNr
Yl9xdWV1ZV9sZW4oJnF1ZXVlLT5jYWIpOworCQkJCWlmIChxdWV1ZSA9PSBlbGVjdGVkX3F1ZXVl
KSB7CisJCQkJCV9fZW50cnktPnZpZl9pZCA9IHd2aWYtPmlkOworCQkJCQlfX2VudHJ5LT5xdWV1
ZV9pZCA9IGk7CisJCQkJfQorCQkJfQorCQl9CisJKSwKKwlUUF9wcmludGsoImdvdCBza2IgZnJv
bSAlZC8lZCwgcGVuZC4gaHcvbm9ybS9jYWI6IFsgJWQvJWQvJWQgJWQvJWQvJWQgJWQvJWQvJWQg
JWQvJWQvJWQgXSBbICVkLyVkLyVkICVkLyVkLyVkICVkLyVkLyVkICVkLyVkLyVkIF0iLAorCQlf
X2VudHJ5LT52aWZfaWQsIF9fZW50cnktPnF1ZXVlX2lkLAorCQlfX2VudHJ5LT5od1swXSwgX19l
bnRyeS0+ZHJ2WzBdLCBfX2VudHJ5LT5jYWJbMF0sCisJCV9fZW50cnktPmh3WzFdLCBfX2VudHJ5
LT5kcnZbMV0sIF9fZW50cnktPmNhYlsxXSwKKwkJX19lbnRyeS0+aHdbMl0sIF9fZW50cnktPmRy
dlsyXSwgX19lbnRyeS0+Y2FiWzJdLAorCQlfX2VudHJ5LT5od1szXSwgX19lbnRyeS0+ZHJ2WzNd
LCBfX2VudHJ5LT5jYWJbM10sCisJCV9fZW50cnktPmh3WzRdLCBfX2VudHJ5LT5kcnZbNF0sIF9f
ZW50cnktPmNhYls0XSwKKwkJX19lbnRyeS0+aHdbNV0sIF9fZW50cnktPmRydls1XSwgX19lbnRy
eS0+Y2FiWzVdLAorCQlfX2VudHJ5LT5od1s2XSwgX19lbnRyeS0+ZHJ2WzZdLCBfX2VudHJ5LT5j
YWJbNl0sCisJCV9fZW50cnktPmh3WzddLCBfX2VudHJ5LT5kcnZbN10sIF9fZW50cnktPmNhYls3
XQorCSkKKyk7CisKKyNlbmRpZgorCisvKiBUaGlzIHBhcnQgbXVzdCBiZSBvdXRzaWRlIHByb3Rl
Y3Rpb24gKi8KKyN1bmRlZiBUUkFDRV9JTkNMVURFX1BBVEgKKyNkZWZpbmUgVFJBQ0VfSU5DTFVE
RV9QQVRIIC4KKyN1bmRlZiBUUkFDRV9JTkNMVURFX0ZJTEUKKyNkZWZpbmUgVFJBQ0VfSU5DTFVE
RV9GSUxFIHRyYWNlcworCisjaW5jbHVkZSA8dHJhY2UvZGVmaW5lX3RyYWNlLmg+Ci0tIAoyLjMz
LjAKCg==
