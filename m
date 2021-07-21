Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427783D1164
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Jul 2021 16:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbhGUNwd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 21 Jul 2021 09:52:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:31256 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237524AbhGUNwd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Jul 2021 09:52:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="211164945"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="211164945"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 07:33:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="662135822"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 07:33:08 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m6DHR-00Gg1v-SR; Wed, 21 Jul 2021 17:33:01 +0300
Date:   Wed, 21 Jul 2021 17:33:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
Message-ID: <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
References: <mvmtukn6bmu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmtukn6bmu.fsf@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jul 21, 2021 at 03:26:49PM +0200, Andreas Schwab wrote:
> This allows the driver to be auto loaded.

Can you elaborate a bit?

The driver has OF compatible strings and should be loaded automatically.

-- 
With Best Regards,
Andy Shevchenko


