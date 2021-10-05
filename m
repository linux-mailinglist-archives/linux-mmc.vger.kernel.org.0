Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E443422936
	for <lists+linux-mmc@lfdr.de>; Tue,  5 Oct 2021 15:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhJEN5j (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 5 Oct 2021 09:57:39 -0400
Received: from mail-bn8nam11on2084.outbound.protection.outlook.com ([40.107.236.84]:36801
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235197AbhJEN4n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 5 Oct 2021 09:56:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn2GpcXqy7ZkiO2K6FtiauFNrKLuXJy8q5nQovny5mp45HlttMU+CHkYV4bVO9JUQf0R3ArvDxBO1rOD6IOoPdA0pIr1UslyEH82hEKw5pmssjnDvVyPekPBNWLeBR5gnO5GoJwFElBwEKicG/DReIHAu37bj0DCfaNkVn29pF3ErCmfhyn5/uf7akBSoA5tNS07PHo4rWzcoA8tamHqGxEiY0nRMDGY1B0uNxfPbBBg8eplLwSU+eEKuDV/TmYyDPMGWOWa6wnzir+cMlqi2hB4j1hs6ZoNnfM9xEDWFKpLX/Ibk1f/wBU3v6tkwDUAzfJn0ki/QnIMn/qA7SdVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTl/TAKX/bV4aKr19XOH8ajjpozCQPm4A57i1QmXgU4=;
 b=Qi+zMtAhbrM5AQwC5IXHkdEiJ4jYU3doaAhjGIgJdV+oEoHjMjUuOsnIEC36Rkew4f6UbM1uTcQJa84jvUpGy/f4+Iq7D9gBRzroa3g5LmxsyISDxzjGbpgvC0IiwxQAUwMigemibLeLT6VhnW7+e29fvTj1ihPfmyh7UolEniFrcE1y22U2zDSTwAf8Pe7cgp1yhlsKQZxc/o1W1Z2HF2h/msYdwj+pXD4Zv/PbI2Etac9b9sBHwiAliL7zCNyplj68NLStPlJA6if0CI4yNNjcfAvktOItPKucFYcj/c2cpbnjQhn1I7iM9Ky9kZYqQ1khpCWbsGcmShW0Yhs+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTl/TAKX/bV4aKr19XOH8ajjpozCQPm4A57i1QmXgU4=;
 b=APmqNiBvp+F7OT8J1AdjLmPIgIeW0XQTNKjW3Uddhck/xtyiR0KV3SwmxOXZrKiHSYW40uW7AAhjSBynPM9URt44mh2hGbFkE1wIR+sXa6sn8pcr0175CVzBndV3Eby3+2yxULhdPN3MzV8oHsryBvrOqHA8pbj2iX2x/xqaLn4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5644.namprd11.prod.outlook.com (2603:10b6:510:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 13:54:49 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::31cb:3b13:b0e8:d8f4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::31cb:3b13:b0e8:d8f4%9]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 13:54:49 +0000
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
Subject: [PATCH v8 10/24] wfx: add fwio.c/fwio.h
Date:   Tue,  5 Oct 2021 15:53:46 +0200
Message-Id: <20211005135400.788058-11-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005135400.788058-1-Jerome.Pouiller@silabs.com>
References: <20211005135400.788058-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
Received: from pc-42.silabs.com (37.71.187.125) by PR3P189CA0084.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 13:54:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ff361e5-7b8b-4c89-c167-08d98807b293
X-MS-TrafficTypeDiagnostic: PH0PR11MB5644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB5644964E77DC27C7B0699FD893AF9@PH0PR11MB5644.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: softAdWd37JzZ8NJq51RRhZ35iiCMXV+/Ypomu4kZM9DGNoujDkCg+1nIAq+G+sdnuVamXXfPvV/Dz+q1btv5sLvFOUCFcs6TAgPY08PcNAQUXjBlNOkLRgxOhcC830EeIsUCPrafC2HfFpDzwMZb0W/rkhJPXck3H5kMYRsKDfah/yM1VFz2WlNHYjCLv/V5EX1Q8DEYcqf3/w5lsH2uXyknSFfSmlITBklKQ7D2s0RNHKivyEFIvZ69eRJAJrkR/qMT1tOqALta7zPAZfQkI1vB1QtgjpVVNIFlJG6qjKFv/odrZQx2QyreIYVTto9g6Rk4d1dfTnrDixITyJjLhPNwCEloWqgcFLcrxomcFqjyrDO8P8kS93/ieBb03KDQDeKX/K3wY93Zva8htfYTQbXgkX5TeMc0PmA5A4Ww01BZPFMs7SMZQBibFqcKbWp6IVQ5UzNXbyqDWGzMtb4DsG/Rxpk/nn9MDmVqcJI7PGqq6tv/028oQ+ZX8AuCsb0cCez2DCfCJz0I+Zii20ilS588TWfGkATD9Vhpr8TVTBke9wmrGbmq9OFTNkseqLFNW6WHfp0DH5QBS4iE8ELvQfUsL5F3gGnmc+YJAHyntN+lFwtWJc4F5s6hLpTd+GWsf5qRc7E9L14DLG1JWi7+l4nacVwV0E8pcBWzvSqFA2dYfiMN9ojij0uHVI7P27V+/R13iK53++sMBTz166ZaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66556008)(8936002)(6916009)(83380400001)(956004)(508600001)(2616005)(66476007)(26005)(186003)(7416002)(2906002)(36756003)(4326008)(30864003)(8676002)(107886003)(66574015)(7696005)(52116002)(38100700002)(316002)(1076003)(5660300002)(86362001)(54906003)(38350700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M00rU0FMYzN0U1hYd1BuQlJKcmh6cGEzZFFURjR5Mms5MXprWUE3Q00vWXVU?=
 =?utf-8?B?L3R6VUtlMjhSUFl6T1QrZWVyRzBTSlBQZDJRZFo1dFhjSENvMEdnNE1CQXdi?=
 =?utf-8?B?T3lVWVNzbzR0SVY3TlN2M01FVzlwZ3V6RkRyOWJiZmd2L0tyb0YzUHdad0lF?=
 =?utf-8?B?VlRFaW1DRlBqRGtSUzZYUFdHSEV0K1R6WFd0RmpiY3ZtcFlMRGVEKzkyTm1a?=
 =?utf-8?B?NjJYUzd3bkE0clp5czFnUmloallkUFMrUzVBZDJZM205WUFjVG1HeTBaNHhy?=
 =?utf-8?B?Z21tM01yTzVvTDFTK2NVUlF0di81OHlnNE9rTGo4dEFKWFpRSzJiRkNQcEN3?=
 =?utf-8?B?bk1BcUdKM3ZWYkkrbU4zQkFaQXRvc1lSMThVczAxU1k5SU1LQXQ3UmloS0lJ?=
 =?utf-8?B?dWcvdFo5dVJvdVdXdC9Xb241SzNsRnhhWnZIS21wY1M3S2tJUllmYkMxVlNa?=
 =?utf-8?B?ZGN4RmVYc2I5SktyM1c1c2lWZTh0aGJkalc5ZVVIcXZRa1dnWUpQM1N2M3Zj?=
 =?utf-8?B?VjU2ZDBTd2FpVGd0UE5oVlBmZlhWTHN2WXBGN0Q0YVkreUdnd1dkd1hZSVdy?=
 =?utf-8?B?eDdLV1JJUWZncEJHS0s2MTJHbGhjdVcxdW9LQjlLTzhiQ2ZFYnZKY0p4VHZl?=
 =?utf-8?B?TTVUSlhsRmdzSTd3UU1rSFdQMnA0andPQ2NiaDdDSEk5NTY5UjdqMGNzT3ZK?=
 =?utf-8?B?dy90YS9wcXJTNSt0dU1zc1lkTlBkUlpSMzNQeElDVStSR0xITXZ3RWZ3NlBN?=
 =?utf-8?B?UDQxS0kxNjdIeTVQcjdBcW1DbHMzUGgvNlJnekpFVXFsNm1aT05LWjdtTktz?=
 =?utf-8?B?R3cySm1IR21JQTVtUk8ycjFQd1duZzVCK1BYcUF0YnJvS0VsOU5pNGpseWgr?=
 =?utf-8?B?UmNEVGVXcGpkRG5sWXNwa21nODEzdE16UGNEZGRlVjN3cU1hT0hvU3pDZ0c2?=
 =?utf-8?B?UUM3ZjNLN2xITE9XRXdtYTBiYWFaeU1RV2hVZjhFNXlpNy9aRG9iUkdUeDlQ?=
 =?utf-8?B?aUJJZENMS1NPdFh0ZFVKMVIySTlEWUFWNXFRa3dXNVl2ZytCeXlFOFFpV204?=
 =?utf-8?B?WkxhbXlrQ3NXQ1M3UlJMS0k1Rll2Ym5HL3dmTjNqR2hDMThtb3JmVHkyeTk0?=
 =?utf-8?B?MzNTWVBsSDF3QUNRMW5lVXB2My82VkVwMTAzOXZoNlpFRlY2b1pGU0hCZmw1?=
 =?utf-8?B?UXNXaVNaYThwbnBBT1F2bnlMei9wRTYrTUFwNWdvb282OE0vYnFpL1lXQVVB?=
 =?utf-8?B?SkorZTMwOU5aM2VFYVM4Z1FvaEpOQlowcS9kMlVCYmF3cXZ3Z2xDS1lCMDBo?=
 =?utf-8?B?djRoTEo4c3k1bEtoMG5KbFpacURqaFVpZ3I2UDE3d0hhNzZxdWhTeG1mV1Bl?=
 =?utf-8?B?cnE1aFpvMXZmYmZ1TDE2UGk2ckxDbEI5Q1A5OHd0UURmcHhJZkpKd01DTWk5?=
 =?utf-8?B?MEZlV1Vtd2l4eWtHUTNBK2FJSXpqOUREYWNSWmNCWVlNcGFwNmsyU2w1UGFw?=
 =?utf-8?B?bW5iVjhYQ3cvTEozeDFLcVZDRWc3eUd4VUJYdkRvaGZ6VUVkZnBWb0N5UmlL?=
 =?utf-8?B?TWE2cE9OdlYxeVVKa1hYUGN6bUZJMW9OZnVJYU1rWTNKcFNnaE1BemJXRlB1?=
 =?utf-8?B?eTUzNjlrWkhPdktGZVZTN0xINUFvY29qWFBBOTJqSmgzNzQ1QVZMUzVWVVgr?=
 =?utf-8?B?SEZvb1NON05NU01kbm94VWdueDBjcGs5TjFDZmc5VDVsNFJ0SUZ2UWV2VmFP?=
 =?utf-8?Q?QWJ2Imm1sUTIpPN5pOK1ZYFe9/Q/nSUxgwSWeCq?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff361e5-7b8b-4c89-c167-08d98807b293
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 13:54:49.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5uafmv/pwQpTYxm+NGp/zf/IbXHWeWfMAnOJkVggRpJvHbUWHWbsHQn8E7M8Y7+p2H7F5wyVVLYvBb4wTAEPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5644
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZndpby5jIHwgNDA1ICsrKysr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZndp
by5oIHwgIDE1ICsKIDIgZmlsZXMgY2hhbmdlZCwgNDIwIGluc2VydGlvbnMoKykKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2Z3aW8uYwogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZndpby5oCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9md2lvLmMgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2Z3aW8uYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwMDAwMDAuLmM5YTU0YzUxOWU4YQotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZndpby5jCkBAIC0wLDAgKzEsNDA1IEBACisvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CisvKgorICogRmlybXdhcmUgbG9hZGlu
Zy4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTctMjAyMCwgU2lsaWNvbiBMYWJvcmF0b3JpZXMs
IEluYy4KKyAqIENvcHlyaWdodCAoYykgMjAxMCwgU1QtRXJpY3Nzb24KKyAqLworI2luY2x1ZGUg
PGxpbnV4L2Zpcm13YXJlLmg+CisjaW5jbHVkZSA8bGludXgvc2xhYi5oPgorI2luY2x1ZGUgPGxp
bnV4L21tLmg+CisjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4KKworI2luY2x1ZGUgImZ3aW8u
aCIKKyNpbmNsdWRlICJ3ZnguaCIKKyNpbmNsdWRlICJod2lvLmgiCisKKy8qIEFkZHJlc3NlcyBi
ZWxvdyBhcmUgaW4gU1JBTSBhcmVhICovCisjZGVmaW5lIFdGWF9ETkxEX0ZJRk8gICAgICAgICAg
ICAgMHgwOTAwNDAwMAorI2RlZmluZSAgICAgRE5MRF9CTE9DS19TSVpFICAgICAgICAgICAweDA0
MDAKKyNkZWZpbmUgICAgIEROTERfRklGT19TSVpFICAgICAgICAgICAgMHg4MDAwIC8qICgzMiAq
IEROTERfQkxPQ0tfU0laRSkgKi8KKy8qIERvd25sb2FkIENvbnRyb2wgQXJlYSAoRENBKSAqLwor
I2RlZmluZSBXRlhfRENBX0lNQUdFX1NJWkUgICAgICAgIDB4MDkwMEMwMDAKKyNkZWZpbmUgV0ZY
X0RDQV9QVVQgICAgICAgICAgICAgICAweDA5MDBDMDA0CisjZGVmaW5lIFdGWF9EQ0FfR0VUICAg
ICAgICAgICAgICAgMHgwOTAwQzAwOAorI2RlZmluZSBXRlhfRENBX0hPU1RfU1RBVFVTICAgICAg
IDB4MDkwMEMwMEMKKyNkZWZpbmUgICAgIEhPU1RfUkVBRFkgICAgICAgICAgICAgICAgMHg4NzY1
NDMyMQorI2RlZmluZSAgICAgSE9TVF9JTkZPX1JFQUQgICAgICAgICAgICAweEE3NTNCRDk5Cisj
ZGVmaW5lICAgICBIT1NUX1VQTE9BRF9QRU5ESU5HICAgICAgIDB4QUJDRERDQkEKKyNkZWZpbmUg
ICAgIEhPU1RfVVBMT0FEX0NPTVBMRVRFICAgICAgMHhENEM2NEE5OQorI2RlZmluZSAgICAgSE9T
VF9PS19UT19KVU1QICAgICAgICAgICAweDE3NEZDODgyCisjZGVmaW5lIFdGWF9EQ0FfTkNQX1NU
QVRVUyAgICAgICAgMHgwOTAwQzAxMAorI2RlZmluZSAgICAgTkNQX05PVF9SRUFEWSAgICAgICAg
ICAgICAweDEyMzQ1Njc4CisjZGVmaW5lICAgICBOQ1BfUkVBRFkgICAgICAgICAgICAgICAgIDB4
ODc2NTQzMjEKKyNkZWZpbmUgICAgIE5DUF9JTkZPX1JFQURZICAgICAgICAgICAgMHhCRDUzRUY5
OQorI2RlZmluZSAgICAgTkNQX0RPV05MT0FEX1BFTkRJTkcgICAgICAweEFCQ0REQ0JBCisjZGVm
aW5lICAgICBOQ1BfRE9XTkxPQURfQ09NUExFVEUgICAgIDB4Q0FGRUZFQ0EKKyNkZWZpbmUgICAg
IE5DUF9BVVRIX09LICAgICAgICAgICAgICAgMHhENEM2NEE5OQorI2RlZmluZSAgICAgTkNQX0FV
VEhfRkFJTCAgICAgICAgICAgICAweDE3NEZDODgyCisjZGVmaW5lICAgICBOQ1BfUFVCX0tFWV9S
RFkgICAgICAgICAgIDB4N0FCNDFEMTkKKyNkZWZpbmUgV0ZYX0RDQV9GV19TSUdOQVRVUkUgICAg
ICAweDA5MDBDMDE0CisjZGVmaW5lICAgICBGV19TSUdOQVRVUkVfU0laRSAgICAgICAgIDB4NDAK
KyNkZWZpbmUgV0ZYX0RDQV9GV19IQVNIICAgICAgICAgICAweDA5MDBDMDU0CisjZGVmaW5lICAg
ICBGV19IQVNIX1NJWkUgICAgICAgICAgICAgIDB4MDgKKyNkZWZpbmUgV0ZYX0RDQV9GV19WRVJT
SU9OICAgICAgICAweDA5MDBDMDVDCisjZGVmaW5lICAgICBGV19WRVJTSU9OX1NJWkUgICAgICAg
ICAgIDB4MDQKKyNkZWZpbmUgV0ZYX0RDQV9SRVNFUlZFRCAgICAgICAgICAweDA5MDBDMDYwCisj
ZGVmaW5lICAgICBEQ0FfUkVTRVJWRURfU0laRSAgICAgICAgIDB4MjAKKyNkZWZpbmUgV0ZYX1NU
QVRVU19JTkZPICAgICAgICAgICAweDA5MDBDMDgwCisjZGVmaW5lIFdGWF9CT09UTE9BREVSX0xB
QkVMICAgICAgMHgwOTAwQzA4NAorI2RlZmluZSAgICAgQk9PVExPQURFUl9MQUJFTF9TSVpFICAg
ICAweDNDCisjZGVmaW5lIFdGWF9QVEVfSU5GTyAgICAgICAgICAgICAgMHgwOTAwQzBDMAorI2Rl
ZmluZSAgICAgUFRFX0lORk9fS0VZU0VUX0lEWCAgICAgICAweDBECisjZGVmaW5lICAgICBQVEVf
SU5GT19TSVpFICAgICAgICAgICAgIDB4MTAKKyNkZWZpbmUgV0ZYX0VSUl9JTkZPICAgICAgICAg
ICAgICAweDA5MDBDMEQwCisjZGVmaW5lICAgICBFUlJfSU5WQUxJRF9TRUNfVFlQRSAgICAgIDB4
MDUKKyNkZWZpbmUgICAgIEVSUl9TSUdfVkVSSUZfRkFJTEVEICAgICAgMHgwRgorI2RlZmluZSAg
ICAgRVJSX0FFU19DVFJMX0tFWSAgICAgICAgICAweDEwCisjZGVmaW5lICAgICBFUlJfRUNDX1BV
Ql9LRVkgICAgICAgICAgIDB4MTEKKyNkZWZpbmUgICAgIEVSUl9NQUNfS0VZICAgICAgICAgICAg
ICAgMHgxOAorCisjZGVmaW5lIERDQV9USU1FT1VUICA1MCAvKiBtaWxsaXNlY29uZHMgKi8KKyNk
ZWZpbmUgV0FLRVVQX1RJTUVPVVQgMjAwIC8qIG1pbGxpc2Vjb25kcyAqLworCitzdGF0aWMgY29u
c3QgY2hhciAqIGNvbnN0IGZ3aW9fZXJyb3JzW10gPSB7CisJW0VSUl9JTlZBTElEX1NFQ19UWVBF
XSA9ICJJbnZhbGlkIHNlY3Rpb24gdHlwZSBvciB3cm9uZyBlbmNyeXB0aW9uIiwKKwlbRVJSX1NJ
R19WRVJJRl9GQUlMRURdID0gIlNpZ25hdHVyZSB2ZXJpZmljYXRpb24gZmFpbGVkIiwKKwlbRVJS
X0FFU19DVFJMX0tFWV0gPSAiQUVTIGNvbnRyb2wga2V5IG5vdCBpbml0aWFsaXplZCIsCisJW0VS
Ul9FQ0NfUFVCX0tFWV0gPSAiRUNDIHB1YmxpYyBrZXkgbm90IGluaXRpYWxpemVkIiwKKwlbRVJS
X01BQ19LRVldID0gIk1BQyBrZXkgbm90IGluaXRpYWxpemVkIiwKK307CisKKy8qIHJlcXVlc3Rf
ZmlybXdhcmUoKSBhbGxvY2F0ZSBkYXRhIHVzaW5nIHZtYWxsb2MoKS4gSXQgaXMgbm90IGNvbXBh
dGlibGUgd2l0aAorICogdW5kZXJseWluZyBoYXJkd2FyZSB0aGF0IHVzZSBETUEuIEZ1bmN0aW9u
IGJlbG93IGRldGVjdCB0aGlzIGNhc2UgYW5kCisgKiBhbGxvY2F0ZSBhIGJvdW5jZSBidWZmZXIg
aWYgbmVjZXNzYXJ5LgorICoKKyAqIE5vdGljZSB0aGF0LCBpbiBkb3VidCwgeW91IGNhbiBlbmFi
bGUgQ09ORklHX0RFQlVHX1NHIHRvIGFzayBrZXJuZWwgdG8KKyAqIGRldGVjdCB0aGlzIHByb2Js
ZW0gYXQgcnVudGltZSAgKGVsc2UsIGtlcm5lbCBzaWxlbnRseSBmYWlsKS4KKyAqCisgKiBOT1RF
OiBpdCBtYXkgYWxzbyBiZSBwb3NzaWJsZSB0byB1c2UgJ3BhZ2VzJyBmcm9tIHN0cnVjdCBmaXJt
d2FyZSBhbmQgYXZvaWQKKyAqIGJvdW5jZSBidWZmZXIKKyAqLworc3RhdGljIGludCB3Znhfc3Jh
bV93cml0ZV9kbWFfc2FmZShzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgdTMyIGFkZHIsCisJCQkJICAg
Y29uc3QgdTggKmJ1Ziwgc2l6ZV90IGxlbikKK3sKKwlpbnQgcmV0OworCWNvbnN0IHU4ICp0bXA7
CisKKwlpZiAoIXZpcnRfYWRkcl92YWxpZChidWYpKSB7CisJCXRtcCA9IGttZW1kdXAoYnVmLCBs
ZW4sIEdGUF9LRVJORUwpOworCQlpZiAoIXRtcCkKKwkJCXJldHVybiAtRU5PTUVNOworCX0gZWxz
ZSB7CisJCXRtcCA9IGJ1ZjsKKwl9CisJcmV0ID0gd2Z4X3NyYW1fYnVmX3dyaXRlKHdkZXYsIGFk
ZHIsIHRtcCwgbGVuKTsKKwlpZiAodG1wICE9IGJ1ZikKKwkJa2ZyZWUodG1wKTsKKwlyZXR1cm4g
cmV0OworfQorCitzdGF0aWMgaW50IGdldF9maXJtd2FyZShzdHJ1Y3Qgd2Z4X2RldiAqd2Rldiwg
dTMyIGtleXNldF9jaGlwLAorCQkJY29uc3Qgc3RydWN0IGZpcm13YXJlICoqZncsIGludCAqZmls
ZV9vZmZzZXQpCit7CisJaW50IGtleXNldF9maWxlOworCWNoYXIgZmlsZW5hbWVbMjU2XTsKKwlj
b25zdCBjaGFyICpkYXRhOworCWludCByZXQ7CisKKwlzbnByaW50ZihmaWxlbmFtZSwgc2l6ZW9m
KGZpbGVuYW1lKSwgIiVzXyUwMlguc2VjIiwKKwkJIHdkZXYtPnBkYXRhLmZpbGVfZncsIGtleXNl
dF9jaGlwKTsKKwlyZXQgPSBmaXJtd2FyZV9yZXF1ZXN0X25vd2FybihmdywgZmlsZW5hbWUsIHdk
ZXYtPmRldik7CisJaWYgKHJldCkgeworCQlkZXZfaW5mbyh3ZGV2LT5kZXYsICJjYW4ndCBsb2Fk
ICVzLCBmYWxsaW5nIGJhY2sgdG8gJXMuc2VjXG4iLAorCQkJIGZpbGVuYW1lLCB3ZGV2LT5wZGF0
YS5maWxlX2Z3KTsKKwkJc25wcmludGYoZmlsZW5hbWUsIHNpemVvZihmaWxlbmFtZSksICIlcy5z
ZWMiLAorCQkJIHdkZXYtPnBkYXRhLmZpbGVfZncpOworCQlyZXQgPSByZXF1ZXN0X2Zpcm13YXJl
KGZ3LCBmaWxlbmFtZSwgd2Rldi0+ZGV2KTsKKwkJaWYgKHJldCkgeworCQkJZGV2X2Vycih3ZGV2
LT5kZXYsICJjYW4ndCBsb2FkICVzXG4iLCBmaWxlbmFtZSk7CisJCQkqZncgPSBOVUxMOworCQkJ
cmV0dXJuIHJldDsKKwkJfQorCX0KKworCWRhdGEgPSAoKmZ3KS0+ZGF0YTsKKwlpZiAobWVtY21w
KGRhdGEsICJLRVlTRVQiLCA2KSAhPSAwKSB7CisJCS8qIExlZ2FjeSBmaXJtd2FyZSBmb3JtYXQg
Ki8KKwkJKmZpbGVfb2Zmc2V0ID0gMDsKKwkJa2V5c2V0X2ZpbGUgPSAweDkwOworCX0gZWxzZSB7
CisJCSpmaWxlX29mZnNldCA9IDg7CisJCWtleXNldF9maWxlID0gKGhleF90b19iaW4oZGF0YVs2
XSkgKiAxNikgfCBoZXhfdG9fYmluKGRhdGFbN10pOworCQlpZiAoa2V5c2V0X2ZpbGUgPCAwKSB7
CisJCQlkZXZfZXJyKHdkZXYtPmRldiwgIiVzIGNvcnJ1cHRlZFxuIiwgZmlsZW5hbWUpOworCQkJ
cmVsZWFzZV9maXJtd2FyZSgqZncpOworCQkJKmZ3ID0gTlVMTDsKKwkJCXJldHVybiAtRUlOVkFM
OworCQl9CisJfQorCWlmIChrZXlzZXRfZmlsZSAhPSBrZXlzZXRfY2hpcCkgeworCQlkZXZfZXJy
KHdkZXYtPmRldiwgImZpcm13YXJlIGtleXNldCBpcyBpbmNvbXBhdGlibGUgd2l0aCBjaGlwIChm
aWxlOiAweCUwMlgsIGNoaXA6IDB4JTAyWClcbiIsCisJCQlrZXlzZXRfZmlsZSwga2V5c2V0X2No
aXApOworCQlyZWxlYXNlX2Zpcm13YXJlKCpmdyk7CisJCSpmdyA9IE5VTEw7CisJCXJldHVybiAt
RU5PREVWOworCX0KKwl3ZGV2LT5rZXlzZXQgPSBrZXlzZXRfZmlsZTsKKwlyZXR1cm4gMDsKK30K
Kworc3RhdGljIGludCB3YWl0X25jcF9zdGF0dXMoc3RydWN0IHdmeF9kZXYgKndkZXYsIHUzMiBz
dGF0dXMpCit7CisJa3RpbWVfdCBub3csIHN0YXJ0OworCXUzMiByZWc7CisJaW50IHJldDsKKwor
CXN0YXJ0ID0ga3RpbWVfZ2V0KCk7CisJZm9yICg7OykgeworCQlyZXQgPSB3Znhfc3JhbV9yZWdf
cmVhZCh3ZGV2LCBXRlhfRENBX05DUF9TVEFUVVMsICZyZWcpOworCQlpZiAocmV0IDwgMCkKKwkJ
CXJldHVybiAtRUlPOworCQlub3cgPSBrdGltZV9nZXQoKTsKKwkJaWYgKHJlZyA9PSBzdGF0dXMp
CisJCQlicmVhazsKKwkJaWYgKGt0aW1lX2FmdGVyKG5vdywga3RpbWVfYWRkX21zKHN0YXJ0LCBE
Q0FfVElNRU9VVCkpKQorCQkJcmV0dXJuIC1FVElNRURPVVQ7CisJfQorCWlmIChrdGltZV9jb21w
YXJlKG5vdywgc3RhcnQpKQorCQlkZXZfZGJnKHdkZXYtPmRldiwgImNoaXAgYW5zd2VyIGFmdGVy
ICVsbGR1c1xuIiwKKwkJCWt0aW1lX3VzX2RlbHRhKG5vdywgc3RhcnQpKTsKKwllbHNlCisJCWRl
dl9kYmcod2Rldi0+ZGV2LCAiY2hpcCBhbnN3ZXIgaW1tZWRpYXRlbHlcbiIpOworCXJldHVybiAw
OworfQorCitzdGF0aWMgaW50IHVwbG9hZF9maXJtd2FyZShzdHJ1Y3Qgd2Z4X2RldiAqd2Rldiwg
Y29uc3QgdTggKmRhdGEsIHNpemVfdCBsZW4pCit7CisJaW50IHJldDsKKwl1MzIgb2ZmcywgYnl0
ZXNfZG9uZSA9IDA7CisJa3RpbWVfdCBub3csIHN0YXJ0OworCisJaWYgKGxlbiAlIEROTERfQkxP
Q0tfU0laRSkgeworCQlkZXZfZXJyKHdkZXYtPmRldiwgImZpcm13YXJlIHNpemUgaXMgbm90IGFs
aWduZWQuIEJ1ZmZlciBvdmVycnVuIHdpbGwgb2NjdXJcbiIpOworCQlyZXR1cm4gLUVJTzsKKwl9
CisJb2ZmcyA9IDA7CisJd2hpbGUgKG9mZnMgPCBsZW4pIHsKKwkJc3RhcnQgPSBrdGltZV9nZXQo
KTsKKwkJZm9yICg7OykgeworCQkJbm93ID0ga3RpbWVfZ2V0KCk7CisJCQlpZiAob2ZmcyArIERO
TERfQkxPQ0tfU0laRSAtIGJ5dGVzX2RvbmUgPCBETkxEX0ZJRk9fU0laRSkKKwkJCQlicmVhazsK
KwkJCWlmIChrdGltZV9hZnRlcihub3csIGt0aW1lX2FkZF9tcyhzdGFydCwgRENBX1RJTUVPVVQp
KSkKKwkJCQlyZXR1cm4gLUVUSU1FRE9VVDsKKwkJCXJldCA9IHdmeF9zcmFtX3JlZ19yZWFkKHdk
ZXYsIFdGWF9EQ0FfR0VULCAmYnl0ZXNfZG9uZSk7CisJCQlpZiAocmV0IDwgMCkKKwkJCQlyZXR1
cm4gcmV0OworCQl9CisJCWlmIChrdGltZV9jb21wYXJlKG5vdywgc3RhcnQpKQorCQkJZGV2X2Ri
Zyh3ZGV2LT5kZXYsICJhbnN3ZXIgYWZ0ZXIgJWxsZHVzXG4iLAorCQkJCWt0aW1lX3VzX2RlbHRh
KG5vdywgc3RhcnQpKTsKKworCQlyZXQgPSB3Znhfc3JhbV93cml0ZV9kbWFfc2FmZSh3ZGV2LAor
CQkJCQkgICAgICBXRlhfRE5MRF9GSUZPICsgKG9mZnMgJSBETkxEX0ZJRk9fU0laRSksCisJCQkJ
CSAgICAgIGRhdGEgKyBvZmZzLCBETkxEX0JMT0NLX1NJWkUpOworCQlpZiAocmV0IDwgMCkKKwkJ
CXJldHVybiByZXQ7CisKKwkJLyogVGhlIGRldmljZSBzZWVtcyB0byBub3Qgc3VwcG9ydCB3cml0
aW5nIDAgaW4gdGhpcyByZWdpc3RlcgorCQkgKiBkdXJpbmcgZmlyc3QgbG9vcAorCQkgKi8KKwkJ
b2ZmcyArPSBETkxEX0JMT0NLX1NJWkU7CisJCXJldCA9IHdmeF9zcmFtX3JlZ193cml0ZSh3ZGV2
LCBXRlhfRENBX1BVVCwgb2Zmcyk7CisJCWlmIChyZXQgPCAwKQorCQkJcmV0dXJuIHJldDsKKwl9
CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyB2b2lkIHByaW50X2Jvb3Rfc3RhdHVzKHN0cnVjdCB3
ZnhfZGV2ICp3ZGV2KQoreworCXUzMiByZWc7CisKKwl3Znhfc3JhbV9yZWdfcmVhZCh3ZGV2LCBX
RlhfU1RBVFVTX0lORk8sICZyZWcpOworCWlmIChyZWcgPT0gMHgxMjM0NTY3OCkKKwkJcmV0dXJu
OworCXdmeF9zcmFtX3JlZ19yZWFkKHdkZXYsIFdGWF9FUlJfSU5GTywgJnJlZyk7CisJaWYgKHJl
ZyA8IEFSUkFZX1NJWkUoZndpb19lcnJvcnMpICYmIGZ3aW9fZXJyb3JzW3JlZ10pCisJCWRldl9p
bmZvKHdkZXYtPmRldiwgInNlY3VyZSBib290OiAlc1xuIiwgZndpb19lcnJvcnNbcmVnXSk7CisJ
ZWxzZQorCQlkZXZfaW5mbyh3ZGV2LT5kZXYsICJzZWN1cmUgYm9vdDogRXJyb3IgJSMwMnhcbiIs
IHJlZyk7Cit9CisKK3N0YXRpYyBpbnQgbG9hZF9maXJtd2FyZV9zZWN1cmUoc3RydWN0IHdmeF9k
ZXYgKndkZXYpCit7CisJY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdyA9IE5VTEw7CisJaW50IGhl
YWRlcl9zaXplOworCWludCBmd19vZmZzZXQ7CisJa3RpbWVfdCBzdGFydDsKKwl1OCAqYnVmOwor
CWludCByZXQ7CisKKwlCVUlMRF9CVUdfT04oUFRFX0lORk9fU0laRSA+IEJPT1RMT0FERVJfTEFC
RUxfU0laRSk7CisJYnVmID0ga21hbGxvYyhCT09UTE9BREVSX0xBQkVMX1NJWkUgKyAxLCBHRlBf
S0VSTkVMKTsKKwlpZiAoIWJ1ZikKKwkJcmV0dXJuIC1FTk9NRU07CisKKwl3Znhfc3JhbV9yZWdf
d3JpdGUod2RldiwgV0ZYX0RDQV9IT1NUX1NUQVRVUywgSE9TVF9SRUFEWSk7CisJcmV0ID0gd2Fp
dF9uY3Bfc3RhdHVzKHdkZXYsIE5DUF9JTkZPX1JFQURZKTsKKwlpZiAocmV0KQorCQlnb3RvIGVy
cm9yOworCisJd2Z4X3NyYW1fYnVmX3JlYWQod2RldiwgV0ZYX0JPT1RMT0FERVJfTEFCRUwsIGJ1
ZiwgQk9PVExPQURFUl9MQUJFTF9TSVpFKTsKKwlidWZbQk9PVExPQURFUl9MQUJFTF9TSVpFXSA9
IDA7CisJZGV2X2RiZyh3ZGV2LT5kZXYsICJib290bG9hZGVyOiBcIiVzXCJcbiIsIGJ1Zik7CisK
Kwl3Znhfc3JhbV9idWZfcmVhZCh3ZGV2LCBXRlhfUFRFX0lORk8sIGJ1ZiwgUFRFX0lORk9fU0la
RSk7CisJcmV0ID0gZ2V0X2Zpcm13YXJlKHdkZXYsIGJ1ZltQVEVfSU5GT19LRVlTRVRfSURYXSwg
JmZ3LCAmZndfb2Zmc2V0KTsKKwlpZiAocmV0KQorCQlnb3RvIGVycm9yOworCWhlYWRlcl9zaXpl
ID0gZndfb2Zmc2V0ICsgRldfU0lHTkFUVVJFX1NJWkUgKyBGV19IQVNIX1NJWkU7CisKKwl3Znhf
c3JhbV9yZWdfd3JpdGUod2RldiwgV0ZYX0RDQV9IT1NUX1NUQVRVUywgSE9TVF9JTkZPX1JFQUQp
OworCXJldCA9IHdhaXRfbmNwX3N0YXR1cyh3ZGV2LCBOQ1BfUkVBRFkpOworCWlmIChyZXQpCisJ
CWdvdG8gZXJyb3I7CisKKwl3Znhfc3JhbV9yZWdfd3JpdGUod2RldiwgV0ZYX0ROTERfRklGTywg
MHhGRkZGRkZGRik7IC8qIEZpZm8gaW5pdCAqLworCXdmeF9zcmFtX3dyaXRlX2RtYV9zYWZlKHdk
ZXYsIFdGWF9EQ0FfRldfVkVSU0lPTiwgIlx4MDFceDAwXHgwMFx4MDAiLAorCQkJCUZXX1ZFUlNJ
T05fU0laRSk7CisJd2Z4X3NyYW1fd3JpdGVfZG1hX3NhZmUod2RldiwgV0ZYX0RDQV9GV19TSUdO
QVRVUkUsIGZ3LT5kYXRhICsgZndfb2Zmc2V0LAorCQkJCUZXX1NJR05BVFVSRV9TSVpFKTsKKwl3
Znhfc3JhbV93cml0ZV9kbWFfc2FmZSh3ZGV2LCBXRlhfRENBX0ZXX0hBU0gsCisJCQkJZnctPmRh
dGEgKyBmd19vZmZzZXQgKyBGV19TSUdOQVRVUkVfU0laRSwKKwkJCQlGV19IQVNIX1NJWkUpOwor
CXdmeF9zcmFtX3JlZ193cml0ZSh3ZGV2LCBXRlhfRENBX0lNQUdFX1NJWkUsIGZ3LT5zaXplIC0g
aGVhZGVyX3NpemUpOworCXdmeF9zcmFtX3JlZ193cml0ZSh3ZGV2LCBXRlhfRENBX0hPU1RfU1RB
VFVTLCBIT1NUX1VQTE9BRF9QRU5ESU5HKTsKKwlyZXQgPSB3YWl0X25jcF9zdGF0dXMod2Rldiwg
TkNQX0RPV05MT0FEX1BFTkRJTkcpOworCWlmIChyZXQpCisJCWdvdG8gZXJyb3I7CisKKwlzdGFy
dCA9IGt0aW1lX2dldCgpOworCXJldCA9IHVwbG9hZF9maXJtd2FyZSh3ZGV2LCBmdy0+ZGF0YSAr
IGhlYWRlcl9zaXplLAorCQkJICAgICAgZnctPnNpemUgLSBoZWFkZXJfc2l6ZSk7CisJaWYgKHJl
dCkKKwkJZ290byBlcnJvcjsKKwlkZXZfZGJnKHdkZXYtPmRldiwgImZpcm13YXJlIGxvYWQgYWZ0
ZXIgJWxsZHVzXG4iLAorCQlrdGltZV91c19kZWx0YShrdGltZV9nZXQoKSwgc3RhcnQpKTsKKwor
CXdmeF9zcmFtX3JlZ193cml0ZSh3ZGV2LCBXRlhfRENBX0hPU1RfU1RBVFVTLCBIT1NUX1VQTE9B
RF9DT01QTEVURSk7CisJcmV0ID0gd2FpdF9uY3Bfc3RhdHVzKHdkZXYsIE5DUF9BVVRIX09LKTsK
KwkvKiBMZWdhY3kgUk9NIHN1cHBvcnQgKi8KKwlpZiAocmV0IDwgMCkKKwkJcmV0ID0gd2FpdF9u
Y3Bfc3RhdHVzKHdkZXYsIE5DUF9QVUJfS0VZX1JEWSk7CisJaWYgKHJldCA8IDApCisJCWdvdG8g
ZXJyb3I7CisJd2Z4X3NyYW1fcmVnX3dyaXRlKHdkZXYsIFdGWF9EQ0FfSE9TVF9TVEFUVVMsIEhP
U1RfT0tfVE9fSlVNUCk7CisKK2Vycm9yOgorCWtmcmVlKGJ1Zik7CisJaWYgKGZ3KQorCQlyZWxl
YXNlX2Zpcm13YXJlKGZ3KTsKKwlpZiAocmV0KQorCQlwcmludF9ib290X3N0YXR1cyh3ZGV2KTsK
KwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgaW50IGluaXRfZ3ByKHN0cnVjdCB3ZnhfZGV2ICp3
ZGV2KQoreworCWludCByZXQsIGk7CisJc3RhdGljIGNvbnN0IHN0cnVjdCB7CisJCWludCBpbmRl
eDsKKwkJdTMyIHZhbHVlOworCX0gZ3ByX2luaXRbXSA9IHsKKwkJeyAweDA3LCAweDIwODc3NSB9
LAorCQl7IDB4MDgsIDB4MkVDMDIwIH0sCisJCXsgMHgwOSwgMHgzQzNDM0MgfSwKKwkJeyAweDBC
LCAweDMyMkM0NCB9LAorCQl7IDB4MEMsIDB4QTA2NDk3IH0sCisJfTsKKworCWZvciAoaSA9IDA7
IGkgPCBBUlJBWV9TSVpFKGdwcl9pbml0KTsgaSsrKSB7CisJCXJldCA9IHdmeF9pZ3ByX3JlZ193
cml0ZSh3ZGV2LCBncHJfaW5pdFtpXS5pbmRleCwKKwkJCQkJIGdwcl9pbml0W2ldLnZhbHVlKTsK
KwkJaWYgKHJldCA8IDApCisJCQlyZXR1cm4gcmV0OworCQlkZXZfZGJnKHdkZXYtPmRldiwgIiAg
aW5kZXggJTAyeDogJTA4eFxuIiwKKwkJCWdwcl9pbml0W2ldLmluZGV4LCBncHJfaW5pdFtpXS52
YWx1ZSk7CisJfQorCXJldHVybiAwOworfQorCitpbnQgd2Z4X2luaXRfZGV2aWNlKHN0cnVjdCB3
ZnhfZGV2ICp3ZGV2KQoreworCWludCByZXQ7CisJaW50IGh3X3JldmlzaW9uLCBod190eXBlOwor
CWludCB3YWtldXBfdGltZW91dCA9IDUwOyAvKiBtcyAqLworCWt0aW1lX3Qgbm93LCBzdGFydDsK
Kwl1MzIgcmVnOworCisJcmVnID0gQ0ZHX0RJUkVDVF9BQ0NFU1NfTU9ERSB8IENGR19DUFVfUkVT
RVQgfCBDRkdfQllURV9PUkRFUl9BQkNEOworCWlmICh3ZGV2LT5wZGF0YS51c2VfcmlzaW5nX2Ns
aykKKwkJcmVnIHw9IENGR19DTEtfUklTRV9FREdFOworCXJldCA9IHdmeF9jb25maWdfcmVnX3dy
aXRlKHdkZXYsIHJlZyk7CisJaWYgKHJldCA8IDApIHsKKwkJZGV2X2Vycih3ZGV2LT5kZXYsICJi
dXMgcmV0dXJuZWQgYW4gZXJyb3IgZHVyaW5nIGZpcnN0IHdyaXRlIGFjY2Vzcy4gSG9zdCBjb25m
aWd1cmF0aW9uIGVycm9yP1xuIik7CisJCXJldHVybiAtRUlPOworCX0KKworCXJldCA9IHdmeF9j
b25maWdfcmVnX3JlYWQod2RldiwgJnJlZyk7CisJaWYgKHJldCA8IDApIHsKKwkJZGV2X2Vycih3
ZGV2LT5kZXYsICJidXMgcmV0dXJuZWQgYW4gZXJyb3IgZHVyaW5nIGZpcnN0IHJlYWQgYWNjZXNz
LiBCdXMgY29uZmlndXJhdGlvbiBlcnJvcj9cbiIpOworCQlyZXR1cm4gLUVJTzsKKwl9CisJaWYg
KHJlZyA9PSAwIHx8IHJlZyA9PSB+MCkgeworCQlkZXZfZXJyKHdkZXYtPmRldiwgImNoaXAgbXV0
ZS4gQnVzIGNvbmZpZ3VyYXRpb24gZXJyb3Igb3IgY2hpcCB3YXNuJ3QgcmVzZXQ/XG4iKTsKKwkJ
cmV0dXJuIC1FSU87CisJfQorCWRldl9kYmcod2Rldi0+ZGV2LCAiaW5pdGlhbCBjb25maWcgcmVn
aXN0ZXIgdmFsdWU6ICUwOHhcbiIsIHJlZyk7CisKKwlod19yZXZpc2lvbiA9IEZJRUxEX0dFVChD
RkdfREVWSUNFX0lEX01BSk9SLCByZWcpOworCWlmIChod19yZXZpc2lvbiA9PSAwKSB7CisJCWRl
dl9lcnIod2Rldi0+ZGV2LCAiYmFkIGhhcmR3YXJlIHJldmlzaW9uIG51bWJlcjogJWRcbiIsCisJ
CQlod19yZXZpc2lvbik7CisJCXJldHVybiAtRU5PREVWOworCX0KKwlod190eXBlID0gRklFTERf
R0VUKENGR19ERVZJQ0VfSURfVFlQRSwgcmVnKTsKKwlpZiAoaHdfdHlwZSA9PSAxKSB7CisJCWRl
dl9ub3RpY2Uod2Rldi0+ZGV2LCAiZGV2ZWxvcG1lbnQgaGFyZHdhcmUgZGV0ZWN0ZWRcbiIpOwor
CQl3YWtldXBfdGltZW91dCA9IDIwMDA7CisJfQorCisJcmV0ID0gaW5pdF9ncHIod2Rldik7CisJ
aWYgKHJldCA8IDApCisJCXJldHVybiByZXQ7CisKKwlyZXQgPSB3ZnhfY29udHJvbF9yZWdfd3Jp
dGUod2RldiwgQ1RSTF9XTEFOX1dBS0VVUCk7CisJaWYgKHJldCA8IDApCisJCXJldHVybiAtRUlP
OworCXN0YXJ0ID0ga3RpbWVfZ2V0KCk7CisJZm9yICg7OykgeworCQlyZXQgPSB3ZnhfY29udHJv
bF9yZWdfcmVhZCh3ZGV2LCAmcmVnKTsKKwkJbm93ID0ga3RpbWVfZ2V0KCk7CisJCWlmIChyZWcg
JiBDVFJMX1dMQU5fUkVBRFkpCisJCQlicmVhazsKKwkJaWYgKGt0aW1lX2FmdGVyKG5vdywga3Rp
bWVfYWRkX21zKHN0YXJ0LCB3YWtldXBfdGltZW91dCkpKSB7CisJCQlkZXZfZXJyKHdkZXYtPmRl
diwgImNoaXAgZGlkbid0IHdha2UgdXAuIENoaXAgd2Fzbid0IHJlc2V0P1xuIik7CisJCQlyZXR1
cm4gLUVUSU1FRE9VVDsKKwkJfQorCX0KKwlkZXZfZGJnKHdkZXYtPmRldiwgImNoaXAgd2FrZSB1
cCBhZnRlciAlbGxkdXNcbiIsCisJCWt0aW1lX3VzX2RlbHRhKG5vdywgc3RhcnQpKTsKKworCXJl
dCA9IHdmeF9jb25maWdfcmVnX3dyaXRlX2JpdHMod2RldiwgQ0ZHX0NQVV9SRVNFVCwgMCk7CisJ
aWYgKHJldCA8IDApCisJCXJldHVybiByZXQ7CisJcmV0ID0gbG9hZF9maXJtd2FyZV9zZWN1cmUo
d2Rldik7CisJaWYgKHJldCA8IDApCisJCXJldHVybiByZXQ7CisJcmV0dXJuIHdmeF9jb25maWdf
cmVnX3dyaXRlX2JpdHMod2RldiwKKwkJCQkJIENGR19ESVJFQ1RfQUNDRVNTX01PREUgfAorCQkJ
CQkgQ0ZHX0lSUV9FTkFCTEVfREFUQSB8CisJCQkJCSBDRkdfSVJRX0VOQUJMRV9XUkRZLAorCQkJ
CQkgQ0ZHX0lSUV9FTkFCTEVfREFUQSk7Cit9CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9zaWxhYnMvd2Z4L2Z3aW8uaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
Zndpby5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uZWVlYTYxMjEw
ZWNhCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9m
d2lvLmgKQEAgLTAsMCArMSwxNSBAQAorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb25seSAqLworLyoKKyAqIEZpcm13YXJlIGxvYWRpbmcuCisgKgorICogQ29weXJpZ2h0IChj
KSAyMDE3LTIwMTksIFNpbGljb24gTGFib3JhdG9yaWVzLCBJbmMuCisgKiBDb3B5cmlnaHQgKGMp
IDIwMTAsIFNULUVyaWNzc29uCisgKi8KKyNpZm5kZWYgV0ZYX0ZXSU9fSAorI2RlZmluZSBXRlhf
RldJT19ICisKK3N0cnVjdCB3ZnhfZGV2OworCitpbnQgd2Z4X2luaXRfZGV2aWNlKHN0cnVjdCB3
ZnhfZGV2ICp3ZGV2KTsKKworI2VuZGlmCi0tIAoyLjMzLjAKCg==
