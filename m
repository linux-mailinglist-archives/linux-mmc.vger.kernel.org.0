Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B480333EFD
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 08:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfFDGaw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 02:30:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42692 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDGaw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 02:30:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x546Ujqd013637;
        Tue, 4 Jun 2019 01:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559629845;
        bh=HvPPDN0cohzBbGAXyF4zGYsuRz1yAnxG8709uSbSji4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xnWCrXf7BHBVW2yOydeLPyUBriHoeCa7BGBJoWlfWg8QnehRuBX/5WGXRMKlA+/RF
         EVeV1f5iMn7+clIJA+P7Lc0mDKgOh6wXS7a9Hc3Fq6O/eSFcCRcUQxFt04mO+vSDeM
         uuvz9oQb7rcLs/xaXcJLP9AfmUNKbOAqHBAdkklo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x546UjTj047896
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 01:30:45 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 01:30:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 01:30:44 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x546Uf9I091770;
        Tue, 4 Jun 2019 01:30:41 -0500
Subject: Re: [PATCH 0/4] Add Support for MMC in J721E
To:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <adrian.hunter@intel.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <nm@ti.com>
References: <20190604060914.10886-1-faiz_abbas@ti.com>
 <2f45cef2-c4ca-0404-b205-fabbb92a40fb@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <93ba4b6d-c878-fe62-2835-366167554ef5@ti.com>
Date:   Tue, 4 Jun 2019 12:01:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2f45cef2-c4ca-0404-b205-fabbb92a40fb@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 04/06/19 11:48 AM, Sekhar Nori wrote:
> On 04/06/19 11:39 AM, Faiz Abbas wrote:
>> The following patches add driver support for MMC SDHCI interfaces on
>> TI's J721E devices. The 8 bit and 4 bit instances have phys which are
>> different from the am65x interfaces as well as different from each
>> other which leads to 3 different compatibles and a bunch of flags for
>> indicating the differences.
>>
>> Depends on Nishanth's initial J721E patches here:
>> https://lore.kernel.org/patchwork/cover/1077382/
> 
> This dependency is only for testing, not for applying these, right?
> 

Yes. The dependency is only for testing.

Thanks,
Faiz
