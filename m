Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263768EA4F
	for <lists+linux-mmc@lfdr.de>; Thu, 15 Aug 2019 13:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfHOLcE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 15 Aug 2019 07:32:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:60872 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfHOLcE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Aug 2019 07:32:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 04:32:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="184598389"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2019 04:32:02 -0700
Subject: Re: [PATCH v3 2/3] PCI: Add Genesys Logic, Inc. Vendor ID
To:     "Michael K. Johnson" <johnsonm@danlj.org>
Cc:     ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20190726020754.GA12078@people.danlj.org>
 <62a756ff-6432-fd43-5e90-038eb28045cd@intel.com>
 <20190812225730.GB30758@people.danlj.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0b195576-48ef-0cff-80c1-b5da47452e96@intel.com>
Date:   Thu, 15 Aug 2019 14:30:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812225730.GB30758@people.danlj.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/08/19 1:57 AM, Michael K. Johnson wrote:
> Add the Genesys Logic, Inc. verndor ID to pci_ids.h.

verndor -> vendor

> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>

Did you mean for this patch to be "From:" Ben Chuang because otherwise
"Co-developed-by" the author is redundant.

> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 70e86148cb1e..4f7e12772a14 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2403,6 +2403,8 @@
>  #define PCI_DEVICE_ID_RDC_R6061		0x6061
>  #define PCI_DEVICE_ID_RDC_D1010		0x1010
>  
> +#define PCI_VENDOR_ID_GLI		0x17a0
> +
>  #define PCI_VENDOR_ID_LENOVO		0x17aa
>  
>  #define PCI_VENDOR_ID_QCOM		0x17cb
> 

