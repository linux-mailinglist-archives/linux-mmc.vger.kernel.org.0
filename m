Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98642CEBB4
	for <lists+linux-mmc@lfdr.de>; Mon,  7 Oct 2019 20:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfJGSYY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 7 Oct 2019 14:24:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40097 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728079AbfJGSYY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Oct 2019 14:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570472663;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eCQBbH69Pg1ZkWDiANjXEs7D77CgeYE54SQ2IQO4wnE=;
        b=DSQ+ZM2Phe6Pkpm886mEt63KYhCW1c0aLwBtKVXh6wfLGMJLKTIcgd3Nl2V9c5TluZ5Wrt
        q/HrGJxCOvh2UjOM3i9PalO+kW7E3D16d8XzEsuMCndJgxt2z5nwCgOC+qHwaogX+to+iE
        kzK/UEU3NrRp6DLbEbHEDaqqeip+ea0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-mfuJOnxSNZKiDeRmiP24Rg-1; Mon, 07 Oct 2019 14:24:18 -0400
Received: by mail-io1-f72.google.com with SMTP id i2so28116503ioo.10
        for <linux-mmc@vger.kernel.org>; Mon, 07 Oct 2019 11:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eCQBbH69Pg1ZkWDiANjXEs7D77CgeYE54SQ2IQO4wnE=;
        b=farHGYQ4oGs90Zuv0HTyQ9Uj8RUaTCeuKXJpQFyZ1FTEmHIiAPA59SUoqUwznkB2GE
         uTXx+6rFPNP4bKZOpOLHlfBzOAB7MBsSK5neURtfI2Zp79x0wWIiGYCPrwNjNsoteiN4
         sl9CBmWnXNL8ce+zoN+TC48CDm0+pGhsb2Aq0B4dotMPX+lGewkPrCvx6nhA8NjlaFAZ
         nxLtmLQMNS2s0UXlDjhFGWnd+8QhbpWAHcWpbLRrV1nKTPbMr2M7vgcn8Ow+ZYPoWWSQ
         0bOhyorEo5MLH0WDoLf6SdQLCQWTKX+Dar3cKb6hOYYADRo6f1zDqfQdwyzh9nt0R3JR
         6a5Q==
X-Gm-Message-State: APjAAAVmJBzNMpwPY47wNIrWzNArHFf7HFyRrsp3r8I6nQgPdJYTgU3P
        kKDh7u0Otfe6bbv8dKNgfLvLvmiXXcj0XK65bLi9bIOCIHBQtwNeqShnXmqr5P3P700l1JOnQM1
        7GhInRVKd17vhhbMXYnEb
X-Received: by 2002:a92:9cca:: with SMTP id x71mr15879281ill.245.1570472658213;
        Mon, 07 Oct 2019 11:24:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRjcepKCt0gHU4J1fh/VS38XxOBSx6x1eDJ//ttvcWAF97bQNybglqC62SyFGnxx6CS0fwfw==
X-Received: by 2002:a92:9cca:: with SMTP id x71mr15879262ill.245.1570472657939;
        Mon, 07 Oct 2019 11:24:17 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l13sm7026832ilq.56.2019.10.07.11.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 11:24:16 -0700 (PDT)
Date:   Mon, 7 Oct 2019 11:24:15 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Message-ID: <20191007182415.ftpojfdluoun34xm@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
 <20190924193739.86133-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20190924193739.86133-7-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: mfuJOnxSNZKiDeRmiP24Rg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue Sep 24 19, Andy Shevchenko wrote:
>Since we have a generic helper, drop custom implementation in the driver.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

