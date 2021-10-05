Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC710422985
	for <lists+linux-mmc@lfdr.de>; Tue,  5 Oct 2021 15:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhJEN7T (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 5 Oct 2021 09:59:19 -0400
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:47152
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236085AbhJEN5x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 5 Oct 2021 09:57:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3INaXsYTV4ojNZybb9Gl9PuD8hXJzHA7QFwCa+ls2iQCpcdfRdKdUuZl6qGAw6EALVsPmx4YKq525v8Gw19F4iCaBKRHZwIvI/MqcaNxSpv9nrfdh3Fwbre4DRswKbEuxggrrWqI7kxhBXq1R6xgFT/vib6AuixMmuwEjNmuq6NqAS0/joNwnp23aWhhZjpN/zidsLn3qT4B4mOfBS0OTLHRZvsovj/ybc3ScLI5BLVB2JYkrYyQMMBosUQaTrek2/iEi6OBhs5/eVzceHTPcCwI3TKMicLSlHs+lSsjpptKzlfgtMMl07YkDTytA9ZmWnewdl5JVbmIdmcUsEAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I2Ep7jGpUHR0Stcx1LoF2xP2D1DDY49iGwXM1hX/es=;
 b=ZvjexcD7vb4tEQpU9D7LKz5DfaRINgavPnB/Sg43aAfyCxj8a3NwnUEyoPQqcwL2rTgn6CS1o/PZIWgPTtazn3H/UaCCzERXbfN00N7DYo162Vn4vYRzU2IAp1H57E4ToVkBwin2BZo7zEmscYcQEjkQdIDrV1TcfNFUIhBpkbixmF4Bl6YVMgwIXMcihpXCDEK6bdwaP57mvCAJtI6ZzVZqjV3PbJIGXKIv84C2ORFt7huGrAn4Zyg33U/kV5bG3mIm/Kfxd4XzK9MKm0OtQ/UHzDpVMMrHqNWqqM3cEbVONypISPILzcVkK2oOA0BvkzmcLhermCjIg0rPXCj2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I2Ep7jGpUHR0Stcx1LoF2xP2D1DDY49iGwXM1hX/es=;
 b=OQpCI0YKy7FOOY1m1WUFFAYfeXJwgB1odZf1Tdl53+j93OpxDZlJd8B/x4NJp8XJUpupbFd8yhQRDCvmWYJbb95XV/UPfc/U69R6JFsef8tDKrToV+BC+3Nzv/8jXcFR86yxhI/iPY/k20ZpF5PTki6iW8WdiHg/DZdfzAI4Lvo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5644.namprd11.prod.outlook.com (2603:10b6:510:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 13:55:01 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::31cb:3b13:b0e8:d8f4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::31cb:3b13:b0e8:d8f4%9]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 13:55:01 +0000
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
Subject: [PATCH v8 14/24] wfx: add key.c/key.h
Date:   Tue,  5 Oct 2021 15:53:50 +0200
Message-Id: <20211005135400.788058-15-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005135400.788058-1-Jerome.Pouiller@silabs.com>
References: <20211005135400.788058-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
Received: from pc-42.silabs.com (37.71.187.125) by PR3P189CA0084.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 13:54:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f154dfeb-9f5b-46fc-b004-08d98807b9ec
X-MS-TrafficTypeDiagnostic: PH0PR11MB5644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB564446CDBF2B4AFDA9C4576693AF9@PH0PR11MB5644.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxwni848xAZNPtesWfLmr21xfsJenejiY+hbmGZlOwTf7764COAgmHrckRbddcmA7Ro/DpYNg/hU2Uq7NlaW1rdazFFsyS17KkBTj4XoRkYY17qsf5vY+0isVbXRO40z1Db/rmQRWe9nHxtn9YoycW91JkzJa/MEp6t7aq+a5R/aZfPJZeSS15KkdmhGFmFap0LAiOgxitIzhGgatv4idp/Garc52rzzogmwbkmAZNoGjk0o/q9/ojMqkvj/VcQEof6EPB4bnJUZoQgdx9q+5SG/V3p4U0ryyhjIFFLxZkgcEx2KksY47TES4YRDP15bOHa8YGWxpBd79QrKofUfRdgraLxmkdSG23xz6t8ROutZuNvHGoNMFc0DDMUGRnziruhkfoRonGgYyv7ekinA7XcpXx9R7qrQ7h+Jhxf39ULbp2h3mcyZaqrSKZ2KA1cplz+myB47W4cELysPsodSLolSYJ5E55MkCojrdLnTZ2gVu2NtAvcWypIuplGQAMOyIc4ZyC2H8NH573SdVYon/CzSeXTA6Si24iFJ0fRS8M/F4q2b8EExyI8k0Qpe5mivEhxsZYRVp9hhlsarHIYnatM1CKhBxaNRHwJ/asTuhtcNoIeBufh7X3rJ08m3byT8MXRJp0xXQOx1KpvxTIy6Xjrfz902g3QBmO5uttN1FkMulGjyYcfqk1fv16VaAiwTAjpxKUO5tjAjbi60778joQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66556008)(8936002)(6916009)(83380400001)(956004)(508600001)(2616005)(66476007)(26005)(186003)(7416002)(2906002)(36756003)(4326008)(8676002)(107886003)(66574015)(7696005)(52116002)(38100700002)(316002)(1076003)(5660300002)(86362001)(6666004)(54906003)(38350700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVFvUXBDNG0yRHhkMm5oWmdLRlUwWnVjVGE5SnV4VWtzU05GdHVpdS9TanZZ?=
 =?utf-8?B?RURGWVh4ZWtsTFVUZGk1Sm1JMDl0Z2hWQzA5andVT2hJcjhyaWwwZDdPVGlj?=
 =?utf-8?B?Yk9QZ1hpd2hvNnpiK1M0bWVPcHVyb1FFY2JtelhHdjlzdFh5dDdSaG0rNHlO?=
 =?utf-8?B?SG1aRjFvWFJqcERTODFiMVE4aEUza0ljV3NFL2JXM0krQy9MVzF2d0Mxc0Qr?=
 =?utf-8?B?Mm5ObGVaL2JDUldScXBFaXZ6MWp2UjYrbE9DazJScXdFS0k4N2tiK3hUV3hO?=
 =?utf-8?B?Ykg5T0Z1eUM3b2J1blNXWWdraHhkSTFVRmNMSHI0YUhucGpvcGtRdGJmaEMx?=
 =?utf-8?B?SDdsY1dMUWFVTUpSODRUcm44bEJsWklOeUlFSk9iVHFlbUFjeUh5eVlRelEz?=
 =?utf-8?B?REdDSEJJMHVHYSttY1lQZGUxV3M0S0pJOXAwRTBQbU9RWU9tNXhTUjVWUzQw?=
 =?utf-8?B?Wkx0WHg3VFpEU1pZZ0FZVkx2OUpOaUsxdEVkNzdRaHloUUZUWTVDSGZBUDNr?=
 =?utf-8?B?dnhGcDkrOWI5dDIrRmFWRDZPRmRTUmdiWGpHWUlvd29Kd2V0aFFaem1hTGFu?=
 =?utf-8?B?dUl3Wjl6UUlwK2hXaHNhRGY2ekprNCsrVFd3U0orajEwcE5EWHdUSEI4dWpJ?=
 =?utf-8?B?ZjZndG1oWmsreHNmbGYvQ0FrcU1mcFQ1Yk9rZTJJREFBZ1IzaFNBeFNvUFJY?=
 =?utf-8?B?RXI1YzBXZENlNVViZVVyY2ZRdnJrNHowNlU4bmtmSDl2NXdzdzAzSEQ4Wjhs?=
 =?utf-8?B?ZVZwNE1ORDRnNm1NZzlOZkxqbTBPSlFnWWI2dVo0MlZLZGd5ZzJiMEgxRElZ?=
 =?utf-8?B?ZGRjaU54NXI2dGYzRTR4NE5QV0wyRGh1Wkh1cjdCdC9GNTVOUyt1RDV3Sitj?=
 =?utf-8?B?cCtma2cwRVBNenhPYlBWOENxRkcxZFNPd1ExMzFZV0tzdG95UnZWYVV1NDY3?=
 =?utf-8?B?aWRuRzByTTdJR1g3SnczSTkwYjBYdG1VbUxJaklXRkg0NGxpZGRPNGhGR3dU?=
 =?utf-8?B?NXcrM2pvTHpoWis5NlFGYlp5QThhTzcvYU42WVBGcG1FL1BnUXNGcFVFekZn?=
 =?utf-8?B?R085ZHByQWVCRnBuaFNxdlIwS2NKTXcySEROQ3htekRwZStPRnlGemJYYWhm?=
 =?utf-8?B?T3ZDRmpBalU3ZmU5L3lZSExsdmJ1dHg2R1VQbnBBQXVoWmZraStjSXlyeFhk?=
 =?utf-8?B?ajNDZjZGNSs4ZHRtNXBuVGhWOGhMWGM4bnpnL2tidUd0QnJPUzhaMm1LSnhy?=
 =?utf-8?B?MCtQMmxHOVEvNE9TaVgzeXJ1dG9lSk5KK3Y3NkFKb29kanNNSlpsWEYzaDQ2?=
 =?utf-8?B?MHJ2cVNtTURFM0syYi9xdXRsMGxzcHcxNG5JQkRRV215bXVvbGt3V3I1UTBS?=
 =?utf-8?B?R1dUWWdZOVZtSzVYem4xa3VaclpsaUlPUmovLzAxZTdEVnAvaEY0OUhDWUl3?=
 =?utf-8?B?dTRUU1QvYm54VHhzbFBrbnhZMEZ1L3dXTTk2dkRKRHdzcUZ0QnN2UW90UmZJ?=
 =?utf-8?B?NDZNR1FWalNYeVBqamNHVWNvTHFPMFJZMkFsYVJhTWxobEJydnhoc05CU3Jo?=
 =?utf-8?B?SWFvWm0rRzRXTXlqZXcxQUZ5aWtpUFRHVVFWM20xTFB1TjJJK1h3NTR1Yy9y?=
 =?utf-8?B?WmJQdXh6WUl0dW1XME0zSmx5NlRaeTNLUFpmN2lZUGo0MHNqNUdXNjZXUXhl?=
 =?utf-8?B?U2w5UVppNXZJMko1WHkyQ1FINnZXREZEMjFrTmNsUVFyMjI5QSs1ZDNXQ3RI?=
 =?utf-8?Q?54A45l/Fk4l2r+ALQkaZF48psQTMWwAVw9LyAAo?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f154dfeb-9f5b-46fc-b004-08d98807b9ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 13:55:01.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWbzE+Tw7nMdrv/MlAzMhqjW/J4fo884npuYfwQl18TfTe2nvVJ9miVPhlQ7qpApm4Fs4c5QCBo/v9aZ91UNeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5644
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngva2V5LmMgfCAyNDEgKysrKysr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngva2V5
LmggfCAgMjAgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDI2MSBpbnNlcnRpb25zKCspCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9rZXkuYwogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngva2V5LmgKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2tleS5jIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9rZXkuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAw
MDAwMDAwMDAwMDAuLmRlYTgyMzhmOTkxNgotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93Zngva2V5LmMKQEAgLTAsMCArMSwyNDEgQEAKKy8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKKy8qCisgKiBLZXkgbWFuYWdlbWVudCByZWxh
dGVkIGZ1bmN0aW9ucy4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTctMjAyMCwgU2lsaWNvbiBM
YWJvcmF0b3JpZXMsIEluYy4KKyAqIENvcHlyaWdodCAoYykgMjAxMCwgU1QtRXJpY3Nzb24KKyAq
LworI2luY2x1ZGUgPGxpbnV4L2V0aGVyZGV2aWNlLmg+CisjaW5jbHVkZSA8bmV0L21hYzgwMjEx
Lmg+CisKKyNpbmNsdWRlICJrZXkuaCIKKyNpbmNsdWRlICJ3ZnguaCIKKyNpbmNsdWRlICJoaWZf
dHhfbWliLmgiCisKK3N0YXRpYyBpbnQgd2Z4X2FsbG9jX2tleShzdHJ1Y3Qgd2Z4X2RldiAqd2Rl
dikKK3sKKwlpbnQgaWR4OworCisJaWR4ID0gZmZzKH53ZGV2LT5rZXlfbWFwKSAtIDE7CisJaWYg
KGlkeCA8IDAgfHwgaWR4ID49IE1BWF9LRVlfRU5UUklFUykKKwkJcmV0dXJuIC0xOworCisJd2Rl
di0+a2V5X21hcCB8PSBCSVQoaWR4KTsKKwlyZXR1cm4gaWR4OworfQorCitzdGF0aWMgdm9pZCB3
ZnhfZnJlZV9rZXkoc3RydWN0IHdmeF9kZXYgKndkZXYsIGludCBpZHgpCit7CisJV0FSTighKHdk
ZXYtPmtleV9tYXAgJiBCSVQoaWR4KSksICJpbmNvbnNpc3RlbnQga2V5IGFsbG9jYXRpb24iKTsK
Kwl3ZGV2LT5rZXlfbWFwICY9IH5CSVQoaWR4KTsKK30KKworc3RhdGljIHU4IGZpbGxfd2VwX3Bh
aXIoc3RydWN0IHdmeF9oaWZfd2VwX3BhaXJ3aXNlX2tleSAqbXNnLAorCQkJc3RydWN0IGllZWU4
MDIxMV9rZXlfY29uZiAqa2V5LCB1OCAqcGVlcl9hZGRyKQoreworCVdBUk4oa2V5LT5rZXlsZW4g
PiBzaXplb2YobXNnLT5rZXlfZGF0YSksICJpbmNvbnNpc3RlbnQgZGF0YSIpOworCW1zZy0+a2V5
X2xlbmd0aCA9IGtleS0+a2V5bGVuOworCW1lbWNweShtc2ctPmtleV9kYXRhLCBrZXktPmtleSwg
a2V5LT5rZXlsZW4pOworCWV0aGVyX2FkZHJfY29weShtc2ctPnBlZXJfYWRkcmVzcywgcGVlcl9h
ZGRyKTsKKwlyZXR1cm4gSElGX0tFWV9UWVBFX1dFUF9QQUlSV0lTRTsKK30KKworc3RhdGljIHU4
IGZpbGxfd2VwX2dyb3VwKHN0cnVjdCB3ZnhfaGlmX3dlcF9ncm91cF9rZXkgKm1zZywKKwkJCSBz
dHJ1Y3QgaWVlZTgwMjExX2tleV9jb25mICprZXkpCit7CisJV0FSTihrZXktPmtleWxlbiA+IHNp
emVvZihtc2ctPmtleV9kYXRhKSwgImluY29uc2lzdGVudCBkYXRhIik7CisJbXNnLT5rZXlfaWQg
PSBrZXktPmtleWlkeDsKKwltc2ctPmtleV9sZW5ndGggPSBrZXktPmtleWxlbjsKKwltZW1jcHko
bXNnLT5rZXlfZGF0YSwga2V5LT5rZXksIGtleS0+a2V5bGVuKTsKKwlyZXR1cm4gSElGX0tFWV9U
WVBFX1dFUF9ERUZBVUxUOworfQorCitzdGF0aWMgdTggZmlsbF90a2lwX3BhaXIoc3RydWN0IHdm
eF9oaWZfdGtpcF9wYWlyd2lzZV9rZXkgKm1zZywKKwkJCSBzdHJ1Y3QgaWVlZTgwMjExX2tleV9j
b25mICprZXksIHU4ICpwZWVyX2FkZHIpCit7CisJdTggKmtleWJ1ZiA9IGtleS0+a2V5OworCisJ
V0FSTihrZXktPmtleWxlbiAhPSBzaXplb2YobXNnLT50a2lwX2tleV9kYXRhKQorCQkJICAgICsg
c2l6ZW9mKG1zZy0+dHhfbWljX2tleSkKKwkJCSAgICArIHNpemVvZihtc2ctPnJ4X21pY19rZXkp
LCAiaW5jb25zaXN0ZW50IGRhdGEiKTsKKwltZW1jcHkobXNnLT50a2lwX2tleV9kYXRhLCBrZXli
dWYsIHNpemVvZihtc2ctPnRraXBfa2V5X2RhdGEpKTsKKwlrZXlidWYgKz0gc2l6ZW9mKG1zZy0+
dGtpcF9rZXlfZGF0YSk7CisJbWVtY3B5KG1zZy0+dHhfbWljX2tleSwga2V5YnVmLCBzaXplb2Yo
bXNnLT50eF9taWNfa2V5KSk7CisJa2V5YnVmICs9IHNpemVvZihtc2ctPnR4X21pY19rZXkpOwor
CW1lbWNweShtc2ctPnJ4X21pY19rZXksIGtleWJ1Ziwgc2l6ZW9mKG1zZy0+cnhfbWljX2tleSkp
OworCWV0aGVyX2FkZHJfY29weShtc2ctPnBlZXJfYWRkcmVzcywgcGVlcl9hZGRyKTsKKwlyZXR1
cm4gSElGX0tFWV9UWVBFX1RLSVBfUEFJUldJU0U7Cit9CisKK3N0YXRpYyB1OCBmaWxsX3RraXBf
Z3JvdXAoc3RydWN0IHdmeF9oaWZfdGtpcF9ncm91cF9rZXkgKm1zZywKKwkJCSAgc3RydWN0IGll
ZWU4MDIxMV9rZXlfY29uZiAqa2V5LAorCQkJICBzdHJ1Y3QgaWVlZTgwMjExX2tleV9zZXEgKnNl
cSwKKwkJCSAgZW51bSBubDgwMjExX2lmdHlwZSBpZnR5cGUpCit7CisJdTggKmtleWJ1ZiA9IGtl
eS0+a2V5OworCisJV0FSTihrZXktPmtleWxlbiAhPSBzaXplb2YobXNnLT50a2lwX2tleV9kYXRh
KQorCQkJICAgICsgMiAqIHNpemVvZihtc2ctPnJ4X21pY19rZXkpLCAiaW5jb25zaXN0ZW50IGRh
dGEiKTsKKwltc2ctPmtleV9pZCA9IGtleS0+a2V5aWR4OworCW1lbWNweShtc2ctPnJ4X3NlcXVl
bmNlX2NvdW50ZXIsCisJICAgICAgICZzZXEtPnRraXAuaXYxNiwgc2l6ZW9mKHNlcS0+dGtpcC5p
djE2KSk7CisJbWVtY3B5KG1zZy0+cnhfc2VxdWVuY2VfY291bnRlciArIHNpemVvZih1MTYpLAor
CSAgICAgICAmc2VxLT50a2lwLml2MzIsIHNpemVvZihzZXEtPnRraXAuaXYzMikpOworCW1lbWNw
eShtc2ctPnRraXBfa2V5X2RhdGEsIGtleWJ1Ziwgc2l6ZW9mKG1zZy0+dGtpcF9rZXlfZGF0YSkp
OworCWtleWJ1ZiArPSBzaXplb2YobXNnLT50a2lwX2tleV9kYXRhKTsKKwlpZiAoaWZ0eXBlID09
IE5MODAyMTFfSUZUWVBFX0FQKQorCQkvKiBVc2UgVHggTUlDIEtleSAqLworCQltZW1jcHkobXNn
LT5yeF9taWNfa2V5LCBrZXlidWYgKyAwLCBzaXplb2YobXNnLT5yeF9taWNfa2V5KSk7CisJZWxz
ZQorCQkvKiBVc2UgUnggTUlDIEtleSAqLworCQltZW1jcHkobXNnLT5yeF9taWNfa2V5LCBrZXli
dWYgKyA4LCBzaXplb2YobXNnLT5yeF9taWNfa2V5KSk7CisJcmV0dXJuIEhJRl9LRVlfVFlQRV9U
S0lQX0dST1VQOworfQorCitzdGF0aWMgdTggZmlsbF9jY21wX3BhaXIoc3RydWN0IHdmeF9oaWZf
YWVzX3BhaXJ3aXNlX2tleSAqbXNnLAorCQkJIHN0cnVjdCBpZWVlODAyMTFfa2V5X2NvbmYgKmtl
eSwgdTggKnBlZXJfYWRkcikKK3sKKwlXQVJOKGtleS0+a2V5bGVuICE9IHNpemVvZihtc2ctPmFl
c19rZXlfZGF0YSksICJpbmNvbnNpc3RlbnQgZGF0YSIpOworCWV0aGVyX2FkZHJfY29weShtc2ct
PnBlZXJfYWRkcmVzcywgcGVlcl9hZGRyKTsKKwltZW1jcHkobXNnLT5hZXNfa2V5X2RhdGEsIGtl
eS0+a2V5LCBrZXktPmtleWxlbik7CisJcmV0dXJuIEhJRl9LRVlfVFlQRV9BRVNfUEFJUldJU0U7
Cit9CisKK3N0YXRpYyB1OCBmaWxsX2NjbXBfZ3JvdXAoc3RydWN0IHdmeF9oaWZfYWVzX2dyb3Vw
X2tleSAqbXNnLAorCQkJICBzdHJ1Y3QgaWVlZTgwMjExX2tleV9jb25mICprZXksCisJCQkgIHN0
cnVjdCBpZWVlODAyMTFfa2V5X3NlcSAqc2VxKQoreworCVdBUk4oa2V5LT5rZXlsZW4gIT0gc2l6
ZW9mKG1zZy0+YWVzX2tleV9kYXRhKSwgImluY29uc2lzdGVudCBkYXRhIik7CisJbWVtY3B5KG1z
Zy0+YWVzX2tleV9kYXRhLCBrZXktPmtleSwga2V5LT5rZXlsZW4pOworCW1lbWNweShtc2ctPnJ4
X3NlcXVlbmNlX2NvdW50ZXIsIHNlcS0+Y2NtcC5wbiwgc2l6ZW9mKHNlcS0+Y2NtcC5wbikpOwor
CW1lbXJldmVyc2UobXNnLT5yeF9zZXF1ZW5jZV9jb3VudGVyLCBzaXplb2Yoc2VxLT5jY21wLnBu
KSk7CisJbXNnLT5rZXlfaWQgPSBrZXktPmtleWlkeDsKKwlyZXR1cm4gSElGX0tFWV9UWVBFX0FF
U19HUk9VUDsKK30KKworc3RhdGljIHU4IGZpbGxfc21zNF9wYWlyKHN0cnVjdCB3ZnhfaGlmX3dh
cGlfcGFpcndpc2Vfa2V5ICptc2csCisJCQkgc3RydWN0IGllZWU4MDIxMV9rZXlfY29uZiAqa2V5
LCB1OCAqcGVlcl9hZGRyKQoreworCXU4ICprZXlidWYgPSBrZXktPmtleTsKKworCVdBUk4oa2V5
LT5rZXlsZW4gIT0gc2l6ZW9mKG1zZy0+d2FwaV9rZXlfZGF0YSkKKwkJCSAgICArIHNpemVvZiht
c2ctPm1pY19rZXlfZGF0YSksICJpbmNvbnNpc3RlbnQgZGF0YSIpOworCWV0aGVyX2FkZHJfY29w
eShtc2ctPnBlZXJfYWRkcmVzcywgcGVlcl9hZGRyKTsKKwltZW1jcHkobXNnLT53YXBpX2tleV9k
YXRhLCBrZXlidWYsIHNpemVvZihtc2ctPndhcGlfa2V5X2RhdGEpKTsKKwlrZXlidWYgKz0gc2l6
ZW9mKG1zZy0+d2FwaV9rZXlfZGF0YSk7CisJbWVtY3B5KG1zZy0+bWljX2tleV9kYXRhLCBrZXli
dWYsIHNpemVvZihtc2ctPm1pY19rZXlfZGF0YSkpOworCW1zZy0+a2V5X2lkID0ga2V5LT5rZXlp
ZHg7CisJcmV0dXJuIEhJRl9LRVlfVFlQRV9XQVBJX1BBSVJXSVNFOworfQorCitzdGF0aWMgdTgg
ZmlsbF9zbXM0X2dyb3VwKHN0cnVjdCB3ZnhfaGlmX3dhcGlfZ3JvdXBfa2V5ICptc2csCisJCQkg
IHN0cnVjdCBpZWVlODAyMTFfa2V5X2NvbmYgKmtleSkKK3sKKwl1OCAqa2V5YnVmID0ga2V5LT5r
ZXk7CisKKwlXQVJOKGtleS0+a2V5bGVuICE9IHNpemVvZihtc2ctPndhcGlfa2V5X2RhdGEpCisJ
CQkgICAgKyBzaXplb2YobXNnLT5taWNfa2V5X2RhdGEpLCAiaW5jb25zaXN0ZW50IGRhdGEiKTsK
KwltZW1jcHkobXNnLT53YXBpX2tleV9kYXRhLCBrZXlidWYsIHNpemVvZihtc2ctPndhcGlfa2V5
X2RhdGEpKTsKKwlrZXlidWYgKz0gc2l6ZW9mKG1zZy0+d2FwaV9rZXlfZGF0YSk7CisJbWVtY3B5
KG1zZy0+bWljX2tleV9kYXRhLCBrZXlidWYsIHNpemVvZihtc2ctPm1pY19rZXlfZGF0YSkpOwor
CW1zZy0+a2V5X2lkID0ga2V5LT5rZXlpZHg7CisJcmV0dXJuIEhJRl9LRVlfVFlQRV9XQVBJX0dS
T1VQOworfQorCitzdGF0aWMgdTggZmlsbF9hZXNfY21hY19ncm91cChzdHJ1Y3Qgd2Z4X2hpZl9p
Z3RrX2dyb3VwX2tleSAqbXNnLAorCQkJICAgICAgc3RydWN0IGllZWU4MDIxMV9rZXlfY29uZiAq
a2V5LAorCQkJICAgICAgc3RydWN0IGllZWU4MDIxMV9rZXlfc2VxICpzZXEpCit7CisJV0FSTihr
ZXktPmtleWxlbiAhPSBzaXplb2YobXNnLT5pZ3RrX2tleV9kYXRhKSwgImluY29uc2lzdGVudCBk
YXRhIik7CisJbWVtY3B5KG1zZy0+aWd0a19rZXlfZGF0YSwga2V5LT5rZXksIGtleS0+a2V5bGVu
KTsKKwltZW1jcHkobXNnLT5pcG4sIHNlcS0+YWVzX2NtYWMucG4sIHNpemVvZihzZXEtPmFlc19j
bWFjLnBuKSk7CisJbWVtcmV2ZXJzZShtc2ctPmlwbiwgc2l6ZW9mKHNlcS0+YWVzX2NtYWMucG4p
KTsKKwltc2ctPmtleV9pZCA9IGtleS0+a2V5aWR4OworCXJldHVybiBISUZfS0VZX1RZUEVfSUdU
S19HUk9VUDsKK30KKworc3RhdGljIGludCB3ZnhfYWRkX2tleShzdHJ1Y3Qgd2Z4X3ZpZiAqd3Zp
Ziwgc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YSwKKwkJICAgICAgIHN0cnVjdCBpZWVlODAyMTFf
a2V5X2NvbmYgKmtleSkKK3sKKwlpbnQgcmV0OworCXN0cnVjdCB3ZnhfaGlmX3JlcV9hZGRfa2V5
IGsgPSB7IH07CisJc3RydWN0IGllZWU4MDIxMV9rZXlfc2VxIHNlcTsKKwlzdHJ1Y3Qgd2Z4X2Rl
diAqd2RldiA9IHd2aWYtPndkZXY7CisJaW50IGlkeCA9IHdmeF9hbGxvY19rZXkod3ZpZi0+d2Rl
dik7CisJYm9vbCBwYWlyd2lzZSA9IGtleS0+ZmxhZ3MgJiBJRUVFODAyMTFfS0VZX0ZMQUdfUEFJ
UldJU0U7CisKKwlXQVJOKGtleS0+ZmxhZ3MgJiBJRUVFODAyMTFfS0VZX0ZMQUdfUEFJUldJU0Ug
JiYgIXN0YSwgImluY29uc2lzdGVudCBkYXRhIik7CisJaWVlZTgwMjExX2dldF9rZXlfcnhfc2Vx
KGtleSwgMCwgJnNlcSk7CisJaWYgKGlkeCA8IDApCisJCXJldHVybiAtRUlOVkFMOworCWsuaW50
X2lkID0gd3ZpZi0+aWQ7CisJay5lbnRyeV9pbmRleCA9IGlkeDsKKwlpZiAoa2V5LT5jaXBoZXIg
PT0gV0xBTl9DSVBIRVJfU1VJVEVfV0VQNDAgfHwKKwkgICAga2V5LT5jaXBoZXIgPT0gV0xBTl9D
SVBIRVJfU1VJVEVfV0VQMTA0KSB7CisJCWlmIChwYWlyd2lzZSkKKwkJCWsudHlwZSA9IGZpbGxf
d2VwX3BhaXIoJmsua2V5LndlcF9wYWlyd2lzZV9rZXksIGtleSwKKwkJCQkJICAgICAgIHN0YS0+
YWRkcik7CisJCWVsc2UKKwkJCWsudHlwZSA9IGZpbGxfd2VwX2dyb3VwKCZrLmtleS53ZXBfZ3Jv
dXBfa2V5LCBrZXkpOworCX0gZWxzZSBpZiAoa2V5LT5jaXBoZXIgPT0gV0xBTl9DSVBIRVJfU1VJ
VEVfVEtJUCkgeworCQlpZiAocGFpcndpc2UpCisJCQlrLnR5cGUgPSBmaWxsX3RraXBfcGFpcigm
ay5rZXkudGtpcF9wYWlyd2lzZV9rZXksIGtleSwKKwkJCQkJCXN0YS0+YWRkcik7CisJCWVsc2UK
KwkJCWsudHlwZSA9IGZpbGxfdGtpcF9ncm91cCgmay5rZXkudGtpcF9ncm91cF9rZXksIGtleSwK
KwkJCQkJCSAmc2VxLCB3dmlmLT52aWYtPnR5cGUpOworCX0gZWxzZSBpZiAoa2V5LT5jaXBoZXIg
PT0gV0xBTl9DSVBIRVJfU1VJVEVfQ0NNUCkgeworCQlpZiAocGFpcndpc2UpCisJCQlrLnR5cGUg
PSBmaWxsX2NjbXBfcGFpcigmay5rZXkuYWVzX3BhaXJ3aXNlX2tleSwga2V5LAorCQkJCQkJc3Rh
LT5hZGRyKTsKKwkJZWxzZQorCQkJay50eXBlID0gZmlsbF9jY21wX2dyb3VwKCZrLmtleS5hZXNf
Z3JvdXBfa2V5LCBrZXksCisJCQkJCQkgJnNlcSk7CisJfSBlbHNlIGlmIChrZXktPmNpcGhlciA9
PSBXTEFOX0NJUEhFUl9TVUlURV9TTVM0KSB7CisJCWlmIChwYWlyd2lzZSkKKwkJCWsudHlwZSA9
IGZpbGxfc21zNF9wYWlyKCZrLmtleS53YXBpX3BhaXJ3aXNlX2tleSwga2V5LAorCQkJCQkJc3Rh
LT5hZGRyKTsKKwkJZWxzZQorCQkJay50eXBlID0gZmlsbF9zbXM0X2dyb3VwKCZrLmtleS53YXBp
X2dyb3VwX2tleSwga2V5KTsKKwl9IGVsc2UgaWYgKGtleS0+Y2lwaGVyID09IFdMQU5fQ0lQSEVS
X1NVSVRFX0FFU19DTUFDKSB7CisJCWsudHlwZSA9IGZpbGxfYWVzX2NtYWNfZ3JvdXAoJmsua2V5
LmlndGtfZ3JvdXBfa2V5LCBrZXksICZzZXEpOworCQlrZXktPmZsYWdzIHw9IElFRUU4MDIxMV9L
RVlfRkxBR19HRU5FUkFURV9NTUlFOworCX0gZWxzZSB7CisJCWRldl93YXJuKHdkZXYtPmRldiwg
InVuc3VwcG9ydGVkIGtleSB0eXBlICVkXG4iLCBrZXktPmNpcGhlcik7CisJCXdmeF9mcmVlX2tl
eSh3ZGV2LCBpZHgpOworCQlyZXR1cm4gLUVPUE5PVFNVUFA7CisJfQorCXJldCA9IHdmeF9oaWZf
YWRkX2tleSh3ZGV2LCAmayk7CisJaWYgKHJldCkgeworCQl3ZnhfZnJlZV9rZXkod2RldiwgaWR4
KTsKKwkJcmV0dXJuIC1FT1BOT1RTVVBQOworCX0KKwlrZXktPmZsYWdzIHw9IElFRUU4MDIxMV9L
RVlfRkxBR19QVVRfSVZfU1BBQ0UgfAorCQkgICAgICBJRUVFODAyMTFfS0VZX0ZMQUdfUkVTRVJW
RV9UQUlMUk9PTTsKKwlrZXktPmh3X2tleV9pZHggPSBpZHg7CisJcmV0dXJuIDA7Cit9CisKK3N0
YXRpYyBpbnQgd2Z4X3JlbW92ZV9rZXkoc3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCBpZWVl
ODAyMTFfa2V5X2NvbmYgKmtleSkKK3sKKwlXQVJOKGtleS0+aHdfa2V5X2lkeCA+PSBNQVhfS0VZ
X0VOVFJJRVMsICJjb3JydXB0ZWQgaHdfa2V5X2lkeCIpOworCXdmeF9mcmVlX2tleSh3dmlmLT53
ZGV2LCBrZXktPmh3X2tleV9pZHgpOworCXJldHVybiB3ZnhfaGlmX3JlbW92ZV9rZXkod3ZpZi0+
d2Rldiwga2V5LT5od19rZXlfaWR4KTsKK30KKworaW50IHdmeF9zZXRfa2V5KHN0cnVjdCBpZWVl
ODAyMTFfaHcgKmh3LCBlbnVtIHNldF9rZXlfY21kIGNtZCwKKwkJc3RydWN0IGllZWU4MDIxMV92
aWYgKnZpZiwgc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YSwKKwkJc3RydWN0IGllZWU4MDIxMV9r
ZXlfY29uZiAqa2V5KQoreworCWludCByZXQgPSAtRU9QTk9UU1VQUDsKKwlzdHJ1Y3Qgd2Z4X3Zp
ZiAqd3ZpZiA9IChzdHJ1Y3Qgd2Z4X3ZpZiAqKXZpZi0+ZHJ2X3ByaXY7CisKKwltdXRleF9sb2Nr
KCZ3dmlmLT53ZGV2LT5jb25mX211dGV4KTsKKwlpZiAoY21kID09IFNFVF9LRVkpCisJCXJldCA9
IHdmeF9hZGRfa2V5KHd2aWYsIHN0YSwga2V5KTsKKwlpZiAoY21kID09IERJU0FCTEVfS0VZKQor
CQlyZXQgPSB3ZnhfcmVtb3ZlX2tleSh3dmlmLCBrZXkpOworCW11dGV4X3VubG9jaygmd3ZpZi0+
d2Rldi0+Y29uZl9tdXRleCk7CisJcmV0dXJuIHJldDsKK30KKwpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9rZXkuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Np
bGFicy93Zngva2V5LmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi4y
ZDEzNWVmZjdhZjIKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxh
YnMvd2Z4L2tleS5oCkBAIC0wLDAgKzEsMjAgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9ubHkgKi8KKy8qCisgKiBLZXkgbWFuYWdlbWVudCByZWxhdGVkIGZ1bmN0aW9u
cy4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTctMjAyMCwgU2lsaWNvbiBMYWJvcmF0b3JpZXMs
IEluYy4KKyAqIENvcHlyaWdodCAoYykgMjAxMCwgU1QtRXJpY3Nzb24KKyAqLworI2lmbmRlZiBX
RlhfS0VZX0gKKyNkZWZpbmUgV0ZYX0tFWV9ICisKKyNpbmNsdWRlIDxuZXQvbWFjODAyMTEuaD4K
Kworc3RydWN0IHdmeF9kZXY7CitzdHJ1Y3Qgd2Z4X3ZpZjsKKworaW50IHdmeF9zZXRfa2V5KHN0
cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBlbnVtIHNldF9rZXlfY21kIGNtZCwKKwkJc3RydWN0IGll
ZWU4MDIxMV92aWYgKnZpZiwgc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YSwKKwkJc3RydWN0IGll
ZWU4MDIxMV9rZXlfY29uZiAqa2V5KTsKKworI2VuZGlmCi0tIAoyLjMzLjAKCg==
