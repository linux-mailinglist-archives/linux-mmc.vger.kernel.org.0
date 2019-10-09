Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37AF1D0B80
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Oct 2019 11:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfJIJkM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 9 Oct 2019 05:40:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:20538 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfJIJkM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Oct 2019 05:40:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 02:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="394962408"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 09 Oct 2019 02:40:06 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iI8Rx-0005PC-C4; Wed, 09 Oct 2019 12:40:05 +0300
Date:   Wed, 9 Oct 2019 12:40:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, robh+dt@kernel.org, mark.rutland@arm.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-arasan: Add Support for Intel LGM
 SDXC
Message-ID: <20191009094005.GB32742@smile.fi.intel.com>
References: <20191003040032.37696-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191003040032.37696-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <2cbda555-42d2-392c-0887-09cae4a35dce@intel.com>
 <38228535-8d4c-76e9-f568-c0dfdc3994b3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38228535-8d4c-76e9-f568-c0dfdc3994b3@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Oct 09, 2019 at 09:06:16AM +0800, Ramuthevar, Vadivel MuruganX wrote:
> Hi Adrian,
> 
> ��� Thank you for the Acked-by, will add *Acked-by* in the next-patch.

Please, stop top-posting.

Besides that, there is no need for next version if the only comments you got
are ACKs. Rb:s, etc.

-- 
With Best Regards,
Andy Shevchenko


