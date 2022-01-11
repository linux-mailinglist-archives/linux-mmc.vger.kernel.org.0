Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3145948B34D
	for <lists+linux-mmc@lfdr.de>; Tue, 11 Jan 2022 18:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344277AbiAKRQZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 11 Jan 2022 12:16:25 -0500
Received: from mail-dm3nam07on2065.outbound.protection.outlook.com ([40.107.95.65]:38465
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243161AbiAKRPn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Jan 2022 12:15:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpTeG1ukapGTwEWqidfMSwys8ADi+x+ND4Fauso2SZDRjldHF2gGnEV7gZbOY8EUqR7doSTObPKYyr2snQz9pHyKxImXjk8xR1iunMUgsEVXltExmIVTojlT5umqQy6wK4ocbDe5M8/o0ZX+s3S7GTDUCZMH8EtWbqUAmOT/afpnU+789khhRboPnmTzyOJnsHmHxo2LhNg2LdLndOkE3s7mrafelUJW9NY1d1IUj3owNScM8TgG/xriy+T+OcTncA3p/ynmH2/eQKLDf35SaK+GA3qtCm0QedAWHfSfPaz4JlsCNZD70CQueGCh9dHSuZWZ25xPVw4sg7HiJNUORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcvmmZeEHk74uZ5bKzNufihgElQ4GY8n/enirfwjy84=;
 b=fo7BvM184ptAxAmqkjiPufyoWC1l5MB/Fplid168uOpUuuyfe30Tre1C0mYDbXX9f57n/RmYX2Kp+upFqQXzJ8yFyqa7BHUYssESI6X+owhsgTAAilKIpLC7s12fQ3vsdjQlcS6hqPB1Ro8Hp+OZsd0JaE6yRhoM/ZIUS5FVMVBfn48mcaDfSxJgiVnIkf0QB02v20TVT7dXNhaeW3whr28MtP9w+QH8w3LafUGqeDPPgsVr0Y1dXmDv7nDjp6Itf5MexXzKGOZ4dV2n0UnUYOClmtCeQN1qWbyPdRee8G/43t6PWmCz13/4sjQXZbDxceoJr2liknW22wRMl7qF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcvmmZeEHk74uZ5bKzNufihgElQ4GY8n/enirfwjy84=;
 b=ZuZKl2F24FYZyXtl4+VGzw1BxhIylOYbdEJLtD/wNoDQfXJdri0D9fiLp1qSXn8Kt1x1Zo34vnDsNjGyIJm1KRIfYCVw0VYfU/oZHiD31A0ZVrMfPdE8zo5WTCsPMYEnVNsfoki8c8iyx3ZwA3aN1ZCOqcp5T/Ed5vhagYx7SyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 17:15:12 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::d031:da9e:71a:73e4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::d031:da9e:71a:73e4%6]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 17:15:12 +0000
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
Subject: [PATCH v9 10/24] wfx: add fwio.c/fwio.h
Date:   Tue, 11 Jan 2022 18:14:10 +0100
Message-Id: <20220111171424.862764-11-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111171424.862764-1-Jerome.Pouiller@silabs.com>
References: <20220111171424.862764-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SN1PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:802:21::34) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26b9d9bb-ced2-490d-e7d5-08d9d525ed22
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB567486B1BFE6D5BE2F24F6EE93519@PH0PR11MB5674.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cq9Rg9v+Pkx+OzDlGr2YUwtJIoHZDd0gQbvqM0KlAzxU+rNxiW9Fg4mSh2M5zCjmyZtoxyg7ohBfHSuePskJduUEZx5rxWKs0rt8Y94Pq+rGpkySwBVx59+AWELYpgYSXBIhxt4eiZEnwE6wWaXMGupXOeG1yNhfZFRroMSHh+67dvKTxvqYNHrSkLUqu15Zf71c0dPX7tKLnywMHBiookKt3/BNE7NqzmmTlhYNBLxIrquuatbr8y14BCH9ltFpLuG8yOA368R0f/SkzkLA0tQtWv8XPX40YlVQxcCc3Nko4ogTWSDoNt5t2P1Ql16aTg6uDi8uRpeDWv5ee41ProzDqb1E7olmlpE+b7UtxOCUL9pIcN1Zi+p2xBa2UWuTH1ocosYctRu3w4BpksIJtz9x0KB68FE9Ne+mKaCpNtdvp/gKnOYcbkXRH9X873k0q/WuWexJz0keFuBduzFKGNiqF6LWJJOtuv8nrikrNz+kKLPwgDHVq0hidVMfG9trgedq8zwL0Cl9ZRhtouW10pwKRNlQS4kq7lTHm2aooTqhq2BE5DUURdwWXoDUMAMtwN8WSY9I/CRijtZTG/cL0f83UK7wCi6cmwQoKhocuuA7hUsDj5QcMba8Q3Sc7mGAgt1nVmHt0jRJJeWHP9lZaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(66946007)(66574015)(8936002)(107886003)(4326008)(66476007)(508600001)(36756003)(7416002)(8676002)(86362001)(6916009)(83380400001)(52116002)(316002)(6512007)(2906002)(30864003)(6486002)(1076003)(186003)(66556008)(54906003)(38100700002)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0hvRFVJWTBORlVubCtiVURCWm5NbnpZNzZGdFJGNlovZExyd1RaYlk1Smtj?=
 =?utf-8?B?NWNFUTgxYkRnRVlWby9IK2EyZ2tkN2FRYkZ3aCtvR3kvbkZra1Y2YkpFRXNi?=
 =?utf-8?B?cExLajZhZVZGSkRaVlJtOUtTZ2EzYWpwUDltVDdtMlNIN1JSL01KMjNFNjFs?=
 =?utf-8?B?YWZKZVhCQXpES25IRDZ4dzd1NlNsTlVrTS91SHhqa3paaDZNRUJ4Z2hFK2Rp?=
 =?utf-8?B?OHdpM3FhakdIR2FTMG9aWlRKOTBtUWkyNVpqQXU3UmluMzZRTUxlY0dIZ0w4?=
 =?utf-8?B?aXUvWjVlMnlZSVRQVng3RnRJTWVsbXMyb2JaRmJnQWhjY3IwVElESjVGRWRl?=
 =?utf-8?B?RWM2UDlvaFJvbnJDUlRHaUdWM04zNVVqV2l5VlYxUjdiNjhOQTBhYlkvZVVk?=
 =?utf-8?B?M1h6U3BXUThENHlpcnZyOWttSWY5S3B4amI0T3JJRUl3cWZwbkRES2o5Zzl4?=
 =?utf-8?B?YWhIWW9iaG9JNlhFNDJoczNyVlJ3aUZhdU56T00yeDJjVmxWajRPaXFLVCtX?=
 =?utf-8?B?K2NjM0VGQWNVbk92TTVEd24rTHZYa0xleHEwTE9xcjlsbnVhdHRQcGFlMXJ1?=
 =?utf-8?B?azNDNXBMUnFiREtkWjZOWW5CQUlOMUdoNDhTcVJEVUhOVk1aUVc2UTBZUk5T?=
 =?utf-8?B?ZVNOcWVZeWl3dFh4UXFtbkRDeEMxcG9Bbi91MlpLRnc5NmtVRDVPb012elpq?=
 =?utf-8?B?Nm5EQUdpM1BVV1FDNFdmMFRyQ1FnYTJhRSt5c0sxdk5KRzRZWUN4VjZ1T0N5?=
 =?utf-8?B?cUJHeGNITGpNTWhtQU9ZbnI3eE5aMml6OFhOOTZubVRMdTN3OVRJdGpWQTNL?=
 =?utf-8?B?a3JKdHI4eG9YdUdQREJtUDZkZUN5QlN5REJjd0dqTVVselBvK1JkY1BEa3Uv?=
 =?utf-8?B?dXo0M0h1QzBNMG9PakdOVlJyV21mZDVLeEs2dVluV3VxQ1pGN1lEMlB0eml0?=
 =?utf-8?B?SmhXSGtTaTFtOFgxRDduRnlUbDg3OHEzMmhkN2NVcHZobHR4bkZGU253MDBY?=
 =?utf-8?B?Y2gxeHNudVRzRm50UGNBOXU0d3VQZkx0ZUYyQUZZYjVjVit5TGN3YVJXMlNY?=
 =?utf-8?B?aHRveERNVjNWY09GenNLRld3TjA5OFhtUFM1SmZHUU0zZXBsWFRqekZTdjZj?=
 =?utf-8?B?SG5LaFN0MjVqTGw4VXhsUnpoYUN1WUtXRUwvOGx6WEFzaXFkeUVUZFNCaFUr?=
 =?utf-8?B?ZERoVnk0dEFEbUlKRW0wVDdsa2diQkN0MXlvK05Ud0NPL1U3cjY5ZkZ5UzQw?=
 =?utf-8?B?cFdnUjZCWWNXRGJqRWZNRndwY25sRWRiVHkwdEJ0ZFV2UUMzOHBJZEtPbVNR?=
 =?utf-8?B?ZFFiRGE4YllLQ2x0TVhtWENHbHhuL0w5Q0lzejYxeE4yT0wyQzJ1TUFydHd6?=
 =?utf-8?B?SjNHL2dOMWdGVnpLQ3VUeVo2dWxRTmNJSjJrVHVPR1RVODB3eFJkUzBQTTNW?=
 =?utf-8?B?azdIVUpzZHpNbFdiVFdWSm1pRzdGT3JCQmo2VktKMFlzNDNrQk44emFUZU1v?=
 =?utf-8?B?bFlRb0wwYXA3WmxQRmVrdnFmSGZ5SEZaZEFDcmo4NGVGelo3SkVyNndRRFp4?=
 =?utf-8?B?WndLSVFVZExXalUyVlVNV25xZXBuZGhsbmdqMmRZZkVBbEh6RW8zb3hQdHFH?=
 =?utf-8?B?ajlNcWxsZHc4V2lHcnlSZnhmY29TeVZUMytSRHRmTGVCTUJBVUR6OVJnR2Yv?=
 =?utf-8?B?bkp4RCtPTmpCeUs4dVRvY28vdndTRnFRVXR5THBIQlBudGVrRjg0MG5TU0pt?=
 =?utf-8?B?dG9NYzdJWVRHcVNPZHdSbVNraUFzTU5KN2ducjhlU2tnRUZaWkdYWUN1ZStT?=
 =?utf-8?B?NGNVMjZMeTFQbTEwaDBtWXI2ZFlTVXptelFKbEp5R0J2RXlsNTYxb1psSmlq?=
 =?utf-8?B?Q09vd3RtZ0pKTmtsVXhlVzZ1QWt4YWZ4djN1a1B1RVVOVktMV3AwV1VURHZC?=
 =?utf-8?B?dU1wZmxkOHE0RWZ4MHlvbXZkbnpiZi85ZnhXWUJqSGdLUWdZdStmNUhzWXlt?=
 =?utf-8?B?c01YOWJtUXhYMXNXaDVlUWMxSXR2VDY1MFVrTjhXcHFlWmRpRktaZlkxTWhD?=
 =?utf-8?B?em82dG9WM0VIcis2ejZyZ1JPcHpuOEFPa1NRTmVWc0d4dkI5UXNxY0t2UUE4?=
 =?utf-8?B?Zm1KUEZFbGk0RjQ5SG1udjY2dHUzZHVHbTdjNno2V0FQUk1IbmMvNmZjcWZJ?=
 =?utf-8?B?SE1KdVQvL0VIWVFTVjRKN3FMR3dUUlVjSFBSRmNOblF0NWNualZsQ21sUExs?=
 =?utf-8?Q?QlGEjKgn9FP5OlEQkAnmJXUgM60cRadOWH09Bww7CQ=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b9d9bb-ced2-490d-e7d5-08d9d525ed22
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:15:12.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouTn2qDb2M1P+7ZwwwNqKq3JYHKZ837wd0fFeS2Gijp3PrtF4GbRkUeG82EvpuaVeW0Cy884g4zsVlxKLbH9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5674
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZndpby5jIHwgMzkwICsrKysr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZndp
by5oIHwgIDE1ICsKIDIgZmlsZXMgY2hhbmdlZCwgNDA1IGluc2VydGlvbnMoKykKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2Z3aW8uYwogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZndpby5oCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9md2lvLmMgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2Z3aW8uYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwMDAwMDAuLjkwMDVhNmZlNDhjOAotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZndpby5jCkBAIC0wLDAgKzEsMzkwIEBACisvLyBTUERY
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
X0FFU19DVFJMX0tFWV0gICAgID0gIkFFUyBjb250cm9sIGtleSBub3QgaW5pdGlhbGl6ZWQiLAor
CVtFUlJfRUNDX1BVQl9LRVldICAgICAgPSAiRUNDIHB1YmxpYyBrZXkgbm90IGluaXRpYWxpemVk
IiwKKwlbRVJSX01BQ19LRVldICAgICAgICAgID0gIk1BQyBrZXkgbm90IGluaXRpYWxpemVkIiwK
K307CisKKy8qIHJlcXVlc3RfZmlybXdhcmUoKSBhbGxvY2F0ZSBkYXRhIHVzaW5nIHZtYWxsb2Mo
KS4gSXQgaXMgbm90IGNvbXBhdGlibGUgd2l0aCB1bmRlcmx5aW5nIGhhcmR3YXJlCisgKiB0aGF0
IHVzZSBETUEuIEZ1bmN0aW9uIGJlbG93IGRldGVjdCB0aGlzIGNhc2UgYW5kIGFsbG9jYXRlIGEg
Ym91bmNlIGJ1ZmZlciBpZiBuZWNlc3NhcnkuCisgKgorICogTm90aWNlIHRoYXQsIGluIGRvdWJ0
LCB5b3UgY2FuIGVuYWJsZSBDT05GSUdfREVCVUdfU0cgdG8gYXNrIGtlcm5lbCB0byBkZXRlY3Qg
dGhpcyBwcm9ibGVtIGF0CisgKiBydW50aW1lICAoZWxzZSwga2VybmVsIHNpbGVudGx5IGZhaWwp
LgorICoKKyAqIE5PVEU6IGl0IG1heSBhbHNvIGJlIHBvc3NpYmxlIHRvIHVzZSAncGFnZXMnIGZy
b20gc3RydWN0IGZpcm13YXJlIGFuZCBhdm9pZCBib3VuY2UgYnVmZmVyCisgKi8KK3N0YXRpYyBp
bnQgd2Z4X3NyYW1fd3JpdGVfZG1hX3NhZmUoc3RydWN0IHdmeF9kZXYgKndkZXYsIHUzMiBhZGRy
LCBjb25zdCB1OCAqYnVmLCBzaXplX3QgbGVuKQoreworCWludCByZXQ7CisJY29uc3QgdTggKnRt
cDsKKworCWlmICghdmlydF9hZGRyX3ZhbGlkKGJ1ZikpIHsKKwkJdG1wID0ga21lbWR1cChidWYs
IGxlbiwgR0ZQX0tFUk5FTCk7CisJCWlmICghdG1wKQorCQkJcmV0dXJuIC1FTk9NRU07CisJfSBl
bHNlIHsKKwkJdG1wID0gYnVmOworCX0KKwlyZXQgPSB3Znhfc3JhbV9idWZfd3JpdGUod2Rldiwg
YWRkciwgdG1wLCBsZW4pOworCWlmICh0bXAgIT0gYnVmKQorCQlrZnJlZSh0bXApOworCXJldHVy
biByZXQ7Cit9CisKK3N0YXRpYyBpbnQgZ2V0X2Zpcm13YXJlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2
LCB1MzIga2V5c2V0X2NoaXAsCisJCQljb25zdCBzdHJ1Y3QgZmlybXdhcmUgKipmdywgaW50ICpm
aWxlX29mZnNldCkKK3sKKwlpbnQga2V5c2V0X2ZpbGU7CisJY2hhciBmaWxlbmFtZVsyNTZdOwor
CWNvbnN0IGNoYXIgKmRhdGE7CisJaW50IHJldDsKKworCXNucHJpbnRmKGZpbGVuYW1lLCBzaXpl
b2YoZmlsZW5hbWUpLCAiJXNfJTAyWC5zZWMiLAorCQkgd2Rldi0+cGRhdGEuZmlsZV9mdywga2V5
c2V0X2NoaXApOworCXJldCA9IGZpcm13YXJlX3JlcXVlc3Rfbm93YXJuKGZ3LCBmaWxlbmFtZSwg
d2Rldi0+ZGV2KTsKKwlpZiAocmV0KSB7CisJCWRldl9pbmZvKHdkZXYtPmRldiwgImNhbid0IGxv
YWQgJXMsIGZhbGxpbmcgYmFjayB0byAlcy5zZWNcbiIsCisJCQkgZmlsZW5hbWUsIHdkZXYtPnBk
YXRhLmZpbGVfZncpOworCQlzbnByaW50ZihmaWxlbmFtZSwgc2l6ZW9mKGZpbGVuYW1lKSwgIiVz
LnNlYyIsIHdkZXYtPnBkYXRhLmZpbGVfZncpOworCQlyZXQgPSByZXF1ZXN0X2Zpcm13YXJlKGZ3
LCBmaWxlbmFtZSwgd2Rldi0+ZGV2KTsKKwkJaWYgKHJldCkgeworCQkJZGV2X2Vycih3ZGV2LT5k
ZXYsICJjYW4ndCBsb2FkICVzXG4iLCBmaWxlbmFtZSk7CisJCQkqZncgPSBOVUxMOworCQkJcmV0
dXJuIHJldDsKKwkJfQorCX0KKworCWRhdGEgPSAoKmZ3KS0+ZGF0YTsKKwlpZiAobWVtY21wKGRh
dGEsICJLRVlTRVQiLCA2KSAhPSAwKSB7CisJCS8qIExlZ2FjeSBmaXJtd2FyZSBmb3JtYXQgKi8K
KwkJKmZpbGVfb2Zmc2V0ID0gMDsKKwkJa2V5c2V0X2ZpbGUgPSAweDkwOworCX0gZWxzZSB7CisJ
CSpmaWxlX29mZnNldCA9IDg7CisJCWtleXNldF9maWxlID0gKGhleF90b19iaW4oZGF0YVs2XSkg
KiAxNikgfCBoZXhfdG9fYmluKGRhdGFbN10pOworCQlpZiAoa2V5c2V0X2ZpbGUgPCAwKSB7CisJ
CQlkZXZfZXJyKHdkZXYtPmRldiwgIiVzIGNvcnJ1cHRlZFxuIiwgZmlsZW5hbWUpOworCQkJcmVs
ZWFzZV9maXJtd2FyZSgqZncpOworCQkJKmZ3ID0gTlVMTDsKKwkJCXJldHVybiAtRUlOVkFMOwor
CQl9CisJfQorCWlmIChrZXlzZXRfZmlsZSAhPSBrZXlzZXRfY2hpcCkgeworCQlkZXZfZXJyKHdk
ZXYtPmRldiwgImZpcm13YXJlIGtleXNldCBpcyBpbmNvbXBhdGlibGUgd2l0aCBjaGlwIChmaWxl
OiAweCUwMlgsIGNoaXA6IDB4JTAyWClcbiIsCisJCQlrZXlzZXRfZmlsZSwga2V5c2V0X2NoaXAp
OworCQlyZWxlYXNlX2Zpcm13YXJlKCpmdyk7CisJCSpmdyA9IE5VTEw7CisJCXJldHVybiAtRU5P
REVWOworCX0KKwl3ZGV2LT5rZXlzZXQgPSBrZXlzZXRfZmlsZTsKKwlyZXR1cm4gMDsKK30KKwor
c3RhdGljIGludCB3YWl0X25jcF9zdGF0dXMoc3RydWN0IHdmeF9kZXYgKndkZXYsIHUzMiBzdGF0
dXMpCit7CisJa3RpbWVfdCBub3csIHN0YXJ0OworCXUzMiByZWc7CisJaW50IHJldDsKKworCXN0
YXJ0ID0ga3RpbWVfZ2V0KCk7CisJZm9yICg7OykgeworCQlyZXQgPSB3Znhfc3JhbV9yZWdfcmVh
ZCh3ZGV2LCBXRlhfRENBX05DUF9TVEFUVVMsICZyZWcpOworCQlpZiAocmV0IDwgMCkKKwkJCXJl
dHVybiAtRUlPOworCQlub3cgPSBrdGltZV9nZXQoKTsKKwkJaWYgKHJlZyA9PSBzdGF0dXMpCisJ
CQlicmVhazsKKwkJaWYgKGt0aW1lX2FmdGVyKG5vdywga3RpbWVfYWRkX21zKHN0YXJ0LCBEQ0Ff
VElNRU9VVCkpKQorCQkJcmV0dXJuIC1FVElNRURPVVQ7CisJfQorCWlmIChrdGltZV9jb21wYXJl
KG5vdywgc3RhcnQpKQorCQlkZXZfZGJnKHdkZXYtPmRldiwgImNoaXAgYW5zd2VyIGFmdGVyICVs
bGR1c1xuIiwga3RpbWVfdXNfZGVsdGEobm93LCBzdGFydCkpOworCWVsc2UKKwkJZGV2X2RiZyh3
ZGV2LT5kZXYsICJjaGlwIGFuc3dlciBpbW1lZGlhdGVseVxuIik7CisJcmV0dXJuIDA7Cit9CisK
K3N0YXRpYyBpbnQgdXBsb2FkX2Zpcm13YXJlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBjb25zdCB1
OCAqZGF0YSwgc2l6ZV90IGxlbikKK3sKKwlpbnQgcmV0OworCXUzMiBvZmZzLCBieXRlc19kb25l
ID0gMDsKKwlrdGltZV90IG5vdywgc3RhcnQ7CisKKwlpZiAobGVuICUgRE5MRF9CTE9DS19TSVpF
KSB7CisJCWRldl9lcnIod2Rldi0+ZGV2LCAiZmlybXdhcmUgc2l6ZSBpcyBub3QgYWxpZ25lZC4g
QnVmZmVyIG92ZXJydW4gd2lsbCBvY2N1clxuIik7CisJCXJldHVybiAtRUlPOworCX0KKwlvZmZz
ID0gMDsKKwl3aGlsZSAob2ZmcyA8IGxlbikgeworCQlzdGFydCA9IGt0aW1lX2dldCgpOworCQlm
b3IgKDs7KSB7CisJCQlub3cgPSBrdGltZV9nZXQoKTsKKwkJCWlmIChvZmZzICsgRE5MRF9CTE9D
S19TSVpFIC0gYnl0ZXNfZG9uZSA8IEROTERfRklGT19TSVpFKQorCQkJCWJyZWFrOworCQkJaWYg
KGt0aW1lX2FmdGVyKG5vdywga3RpbWVfYWRkX21zKHN0YXJ0LCBEQ0FfVElNRU9VVCkpKQorCQkJ
CXJldHVybiAtRVRJTUVET1VUOworCQkJcmV0ID0gd2Z4X3NyYW1fcmVnX3JlYWQod2RldiwgV0ZY
X0RDQV9HRVQsICZieXRlc19kb25lKTsKKwkJCWlmIChyZXQgPCAwKQorCQkJCXJldHVybiByZXQ7
CisJCX0KKwkJaWYgKGt0aW1lX2NvbXBhcmUobm93LCBzdGFydCkpCisJCQlkZXZfZGJnKHdkZXYt
PmRldiwgImFuc3dlciBhZnRlciAlbGxkdXNcbiIsCisJCQkJa3RpbWVfdXNfZGVsdGEobm93LCBz
dGFydCkpOworCisJCXJldCA9IHdmeF9zcmFtX3dyaXRlX2RtYV9zYWZlKHdkZXYsIFdGWF9ETkxE
X0ZJRk8gKyAob2ZmcyAlIEROTERfRklGT19TSVpFKSwKKwkJCQkJICAgICAgZGF0YSArIG9mZnMs
IEROTERfQkxPQ0tfU0laRSk7CisJCWlmIChyZXQgPCAwKQorCQkJcmV0dXJuIHJldDsKKworCQkv
KiBUaGUgZGV2aWNlIHNlZW1zIHRvIG5vdCBzdXBwb3J0IHdyaXRpbmcgMCBpbiB0aGlzIHJlZ2lz
dGVyIGR1cmluZyBmaXJzdCBsb29wICovCisJCW9mZnMgKz0gRE5MRF9CTE9DS19TSVpFOworCQly
ZXQgPSB3Znhfc3JhbV9yZWdfd3JpdGUod2RldiwgV0ZYX0RDQV9QVVQsIG9mZnMpOworCQlpZiAo
cmV0IDwgMCkKKwkJCXJldHVybiByZXQ7CisJfQorCXJldHVybiAwOworfQorCitzdGF0aWMgdm9p
ZCBwcmludF9ib290X3N0YXR1cyhzdHJ1Y3Qgd2Z4X2RldiAqd2RldikKK3sKKwl1MzIgcmVnOwor
CisJd2Z4X3NyYW1fcmVnX3JlYWQod2RldiwgV0ZYX1NUQVRVU19JTkZPLCAmcmVnKTsKKwlpZiAo
cmVnID09IDB4MTIzNDU2NzgpCisJCXJldHVybjsKKwl3Znhfc3JhbV9yZWdfcmVhZCh3ZGV2LCBX
RlhfRVJSX0lORk8sICZyZWcpOworCWlmIChyZWcgPCBBUlJBWV9TSVpFKGZ3aW9fZXJyb3JzKSAm
JiBmd2lvX2Vycm9yc1tyZWddKQorCQlkZXZfaW5mbyh3ZGV2LT5kZXYsICJzZWN1cmUgYm9vdDog
JXNcbiIsIGZ3aW9fZXJyb3JzW3JlZ10pOworCWVsc2UKKwkJZGV2X2luZm8od2Rldi0+ZGV2LCAi
c2VjdXJlIGJvb3Q6IEVycm9yICUjMDJ4XG4iLCByZWcpOworfQorCitzdGF0aWMgaW50IGxvYWRf
ZmlybXdhcmVfc2VjdXJlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQoreworCWNvbnN0IHN0cnVjdCBm
aXJtd2FyZSAqZncgPSBOVUxMOworCWludCBoZWFkZXJfc2l6ZTsKKwlpbnQgZndfb2Zmc2V0Owor
CWt0aW1lX3Qgc3RhcnQ7CisJdTggKmJ1ZjsKKwlpbnQgcmV0OworCisJQlVJTERfQlVHX09OKFBU
RV9JTkZPX1NJWkUgPiBCT09UTE9BREVSX0xBQkVMX1NJWkUpOworCWJ1ZiA9IGttYWxsb2MoQk9P
VExPQURFUl9MQUJFTF9TSVpFICsgMSwgR0ZQX0tFUk5FTCk7CisJaWYgKCFidWYpCisJCXJldHVy
biAtRU5PTUVNOworCisJd2Z4X3NyYW1fcmVnX3dyaXRlKHdkZXYsIFdGWF9EQ0FfSE9TVF9TVEFU
VVMsIEhPU1RfUkVBRFkpOworCXJldCA9IHdhaXRfbmNwX3N0YXR1cyh3ZGV2LCBOQ1BfSU5GT19S
RUFEWSk7CisJaWYgKHJldCkKKwkJZ290byBlcnJvcjsKKworCXdmeF9zcmFtX2J1Zl9yZWFkKHdk
ZXYsIFdGWF9CT09UTE9BREVSX0xBQkVMLCBidWYsIEJPT1RMT0FERVJfTEFCRUxfU0laRSk7CisJ
YnVmW0JPT1RMT0FERVJfTEFCRUxfU0laRV0gPSAwOworCWRldl9kYmcod2Rldi0+ZGV2LCAiYm9v
dGxvYWRlcjogXCIlc1wiXG4iLCBidWYpOworCisJd2Z4X3NyYW1fYnVmX3JlYWQod2RldiwgV0ZY
X1BURV9JTkZPLCBidWYsIFBURV9JTkZPX1NJWkUpOworCXJldCA9IGdldF9maXJtd2FyZSh3ZGV2
LCBidWZbUFRFX0lORk9fS0VZU0VUX0lEWF0sICZmdywgJmZ3X29mZnNldCk7CisJaWYgKHJldCkK
KwkJZ290byBlcnJvcjsKKwloZWFkZXJfc2l6ZSA9IGZ3X29mZnNldCArIEZXX1NJR05BVFVSRV9T
SVpFICsgRldfSEFTSF9TSVpFOworCisJd2Z4X3NyYW1fcmVnX3dyaXRlKHdkZXYsIFdGWF9EQ0Ff
SE9TVF9TVEFUVVMsIEhPU1RfSU5GT19SRUFEKTsKKwlyZXQgPSB3YWl0X25jcF9zdGF0dXMod2Rl
diwgTkNQX1JFQURZKTsKKwlpZiAocmV0KQorCQlnb3RvIGVycm9yOworCisJd2Z4X3NyYW1fcmVn
X3dyaXRlKHdkZXYsIFdGWF9ETkxEX0ZJRk8sIDB4RkZGRkZGRkYpOyAvKiBGaWZvIGluaXQgKi8K
Kwl3Znhfc3JhbV93cml0ZV9kbWFfc2FmZSh3ZGV2LCBXRlhfRENBX0ZXX1ZFUlNJT04sICJceDAx
XHgwMFx4MDBceDAwIiwgRldfVkVSU0lPTl9TSVpFKTsKKwl3Znhfc3JhbV93cml0ZV9kbWFfc2Fm
ZSh3ZGV2LCBXRlhfRENBX0ZXX1NJR05BVFVSRSwgZnctPmRhdGEgKyBmd19vZmZzZXQsCisJCQkJ
RldfU0lHTkFUVVJFX1NJWkUpOworCXdmeF9zcmFtX3dyaXRlX2RtYV9zYWZlKHdkZXYsIFdGWF9E
Q0FfRldfSEFTSCwgZnctPmRhdGEgKyBmd19vZmZzZXQgKyBGV19TSUdOQVRVUkVfU0laRSwKKwkJ
CQlGV19IQVNIX1NJWkUpOworCXdmeF9zcmFtX3JlZ193cml0ZSh3ZGV2LCBXRlhfRENBX0lNQUdF
X1NJWkUsIGZ3LT5zaXplIC0gaGVhZGVyX3NpemUpOworCXdmeF9zcmFtX3JlZ193cml0ZSh3ZGV2
LCBXRlhfRENBX0hPU1RfU1RBVFVTLCBIT1NUX1VQTE9BRF9QRU5ESU5HKTsKKwlyZXQgPSB3YWl0
X25jcF9zdGF0dXMod2RldiwgTkNQX0RPV05MT0FEX1BFTkRJTkcpOworCWlmIChyZXQpCisJCWdv
dG8gZXJyb3I7CisKKwlzdGFydCA9IGt0aW1lX2dldCgpOworCXJldCA9IHVwbG9hZF9maXJtd2Fy
ZSh3ZGV2LCBmdy0+ZGF0YSArIGhlYWRlcl9zaXplLCBmdy0+c2l6ZSAtIGhlYWRlcl9zaXplKTsK
KwlpZiAocmV0KQorCQlnb3RvIGVycm9yOworCWRldl9kYmcod2Rldi0+ZGV2LCAiZmlybXdhcmUg
bG9hZCBhZnRlciAlbGxkdXNcbiIsCisJCWt0aW1lX3VzX2RlbHRhKGt0aW1lX2dldCgpLCBzdGFy
dCkpOworCisJd2Z4X3NyYW1fcmVnX3dyaXRlKHdkZXYsIFdGWF9EQ0FfSE9TVF9TVEFUVVMsIEhP
U1RfVVBMT0FEX0NPTVBMRVRFKTsKKwlyZXQgPSB3YWl0X25jcF9zdGF0dXMod2RldiwgTkNQX0FV
VEhfT0spOworCS8qIExlZ2FjeSBST00gc3VwcG9ydCAqLworCWlmIChyZXQgPCAwKQorCQlyZXQg
PSB3YWl0X25jcF9zdGF0dXMod2RldiwgTkNQX1BVQl9LRVlfUkRZKTsKKwlpZiAocmV0IDwgMCkK
KwkJZ290byBlcnJvcjsKKwl3Znhfc3JhbV9yZWdfd3JpdGUod2RldiwgV0ZYX0RDQV9IT1NUX1NU
QVRVUywgSE9TVF9PS19UT19KVU1QKTsKKworZXJyb3I6CisJa2ZyZWUoYnVmKTsKKwlpZiAoZncp
CisJCXJlbGVhc2VfZmlybXdhcmUoZncpOworCWlmIChyZXQpCisJCXByaW50X2Jvb3Rfc3RhdHVz
KHdkZXYpOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgaW5pdF9ncHIoc3RydWN0IHdm
eF9kZXYgKndkZXYpCit7CisJaW50IHJldCwgaTsKKwlzdGF0aWMgY29uc3Qgc3RydWN0IHsKKwkJ
aW50IGluZGV4OworCQl1MzIgdmFsdWU7CisJfSBncHJfaW5pdFtdID0geworCQl7IDB4MDcsIDB4
MjA4Nzc1IH0sCisJCXsgMHgwOCwgMHgyRUMwMjAgfSwKKwkJeyAweDA5LCAweDNDM0MzQyB9LAor
CQl7IDB4MEIsIDB4MzIyQzQ0IH0sCisJCXsgMHgwQywgMHhBMDY0OTcgfSwKKwl9OworCisJZm9y
IChpID0gMDsgaSA8IEFSUkFZX1NJWkUoZ3ByX2luaXQpOyBpKyspIHsKKwkJcmV0ID0gd2Z4X2ln
cHJfcmVnX3dyaXRlKHdkZXYsIGdwcl9pbml0W2ldLmluZGV4LCBncHJfaW5pdFtpXS52YWx1ZSk7
CisJCWlmIChyZXQgPCAwKQorCQkJcmV0dXJuIHJldDsKKwkJZGV2X2RiZyh3ZGV2LT5kZXYsICIg
IGluZGV4ICUwMng6ICUwOHhcbiIsIGdwcl9pbml0W2ldLmluZGV4LCBncHJfaW5pdFtpXS52YWx1
ZSk7CisJfQorCXJldHVybiAwOworfQorCitpbnQgd2Z4X2luaXRfZGV2aWNlKHN0cnVjdCB3Znhf
ZGV2ICp3ZGV2KQoreworCWludCByZXQ7CisJaW50IGh3X3JldmlzaW9uLCBod190eXBlOworCWlu
dCB3YWtldXBfdGltZW91dCA9IDUwOyAvKiBtcyAqLworCWt0aW1lX3Qgbm93LCBzdGFydDsKKwl1
MzIgcmVnOworCisJcmVnID0gQ0ZHX0RJUkVDVF9BQ0NFU1NfTU9ERSB8IENGR19DUFVfUkVTRVQg
fCBDRkdfQllURV9PUkRFUl9BQkNEOworCWlmICh3ZGV2LT5wZGF0YS51c2VfcmlzaW5nX2NsaykK
KwkJcmVnIHw9IENGR19DTEtfUklTRV9FREdFOworCXJldCA9IHdmeF9jb25maWdfcmVnX3dyaXRl
KHdkZXYsIHJlZyk7CisJaWYgKHJldCA8IDApIHsKKwkJZGV2X2Vycih3ZGV2LT5kZXYsICJidXMg
cmV0dXJuZWQgYW4gZXJyb3IgZHVyaW5nIGZpcnN0IHdyaXRlIGFjY2Vzcy4gSG9zdCBjb25maWd1
cmF0aW9uIGVycm9yP1xuIik7CisJCXJldHVybiAtRUlPOworCX0KKworCXJldCA9IHdmeF9jb25m
aWdfcmVnX3JlYWQod2RldiwgJnJlZyk7CisJaWYgKHJldCA8IDApIHsKKwkJZGV2X2Vycih3ZGV2
LT5kZXYsICJidXMgcmV0dXJuZWQgYW4gZXJyb3IgZHVyaW5nIGZpcnN0IHJlYWQgYWNjZXNzLiBC
dXMgY29uZmlndXJhdGlvbiBlcnJvcj9cbiIpOworCQlyZXR1cm4gLUVJTzsKKwl9CisJaWYgKHJl
ZyA9PSAwIHx8IHJlZyA9PSB+MCkgeworCQlkZXZfZXJyKHdkZXYtPmRldiwgImNoaXAgbXV0ZS4g
QnVzIGNvbmZpZ3VyYXRpb24gZXJyb3Igb3IgY2hpcCB3YXNuJ3QgcmVzZXQ/XG4iKTsKKwkJcmV0
dXJuIC1FSU87CisJfQorCWRldl9kYmcod2Rldi0+ZGV2LCAiaW5pdGlhbCBjb25maWcgcmVnaXN0
ZXIgdmFsdWU6ICUwOHhcbiIsIHJlZyk7CisKKwlod19yZXZpc2lvbiA9IEZJRUxEX0dFVChDRkdf
REVWSUNFX0lEX01BSk9SLCByZWcpOworCWlmIChod19yZXZpc2lvbiA9PSAwKSB7CisJCWRldl9l
cnIod2Rldi0+ZGV2LCAiYmFkIGhhcmR3YXJlIHJldmlzaW9uIG51bWJlcjogJWRcbiIsIGh3X3Jl
dmlzaW9uKTsKKwkJcmV0dXJuIC1FTk9ERVY7CisJfQorCWh3X3R5cGUgPSBGSUVMRF9HRVQoQ0ZH
X0RFVklDRV9JRF9UWVBFLCByZWcpOworCWlmIChod190eXBlID09IDEpIHsKKwkJZGV2X25vdGlj
ZSh3ZGV2LT5kZXYsICJkZXZlbG9wbWVudCBoYXJkd2FyZSBkZXRlY3RlZFxuIik7CisJCXdha2V1
cF90aW1lb3V0ID0gMjAwMDsKKwl9CisKKwlyZXQgPSBpbml0X2dwcih3ZGV2KTsKKwlpZiAocmV0
IDwgMCkKKwkJcmV0dXJuIHJldDsKKworCXJldCA9IHdmeF9jb250cm9sX3JlZ193cml0ZSh3ZGV2
LCBDVFJMX1dMQU5fV0FLRVVQKTsKKwlpZiAocmV0IDwgMCkKKwkJcmV0dXJuIC1FSU87CisJc3Rh
cnQgPSBrdGltZV9nZXQoKTsKKwlmb3IgKDs7KSB7CisJCXJldCA9IHdmeF9jb250cm9sX3JlZ19y
ZWFkKHdkZXYsICZyZWcpOworCQlub3cgPSBrdGltZV9nZXQoKTsKKwkJaWYgKHJlZyAmIENUUkxf
V0xBTl9SRUFEWSkKKwkJCWJyZWFrOworCQlpZiAoa3RpbWVfYWZ0ZXIobm93LCBrdGltZV9hZGRf
bXMoc3RhcnQsIHdha2V1cF90aW1lb3V0KSkpIHsKKwkJCWRldl9lcnIod2Rldi0+ZGV2LCAiY2hp
cCBkaWRuJ3Qgd2FrZSB1cC4gQ2hpcCB3YXNuJ3QgcmVzZXQ/XG4iKTsKKwkJCXJldHVybiAtRVRJ
TUVET1VUOworCQl9CisJfQorCWRldl9kYmcod2Rldi0+ZGV2LCAiY2hpcCB3YWtlIHVwIGFmdGVy
ICVsbGR1c1xuIiwga3RpbWVfdXNfZGVsdGEobm93LCBzdGFydCkpOworCisJcmV0ID0gd2Z4X2Nv
bmZpZ19yZWdfd3JpdGVfYml0cyh3ZGV2LCBDRkdfQ1BVX1JFU0VULCAwKTsKKwlpZiAocmV0IDwg
MCkKKwkJcmV0dXJuIHJldDsKKwlyZXQgPSBsb2FkX2Zpcm13YXJlX3NlY3VyZSh3ZGV2KTsKKwlp
ZiAocmV0IDwgMCkKKwkJcmV0dXJuIHJldDsKKwlyZXR1cm4gd2Z4X2NvbmZpZ19yZWdfd3JpdGVf
Yml0cyh3ZGV2LAorCQkJCQkgQ0ZHX0RJUkVDVF9BQ0NFU1NfTU9ERSB8CisJCQkJCSBDRkdfSVJR
X0VOQUJMRV9EQVRBIHwKKwkJCQkJIENGR19JUlFfRU5BQkxFX1dSRFksCisJCQkJCSBDRkdfSVJR
X0VOQUJMRV9EQVRBKTsKK30KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFi
cy93ZngvZndpby5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9md2lvLmgKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi5lZWVhNjEyMTBlY2EKLS0tIC9k
ZXYvbnVsbAorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2Z3aW8uaApAQCAt
MCwwICsxLDE1IEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICov
CisvKgorICogRmlybXdhcmUgbG9hZGluZy4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTctMjAx
OSwgU2lsaWNvbiBMYWJvcmF0b3JpZXMsIEluYy4KKyAqIENvcHlyaWdodCAoYykgMjAxMCwgU1Qt
RXJpY3Nzb24KKyAqLworI2lmbmRlZiBXRlhfRldJT19ICisjZGVmaW5lIFdGWF9GV0lPX0gKKwor
c3RydWN0IHdmeF9kZXY7CisKK2ludCB3ZnhfaW5pdF9kZXZpY2Uoc3RydWN0IHdmeF9kZXYgKndk
ZXYpOworCisjZW5kaWYKLS0gCjIuMzQuMQoK
