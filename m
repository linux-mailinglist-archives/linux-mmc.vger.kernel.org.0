Return-Path: <linux-mmc+bounces-2884-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE24919871
	for <lists+linux-mmc@lfdr.de>; Wed, 26 Jun 2024 21:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6004C1C21D67
	for <lists+linux-mmc@lfdr.de>; Wed, 26 Jun 2024 19:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC43192B8E;
	Wed, 26 Jun 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KccNg6bD"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA721922FC
	for <linux-mmc@vger.kernel.org>; Wed, 26 Jun 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431036; cv=none; b=BOvUmFLzpnzOJpTT3CtUXzsGoVdQRSNqvFw+95hBKgSpKJFf6q+MC3typdwicyyK8A/9IPpsY1JxWH/Vr4ILEFpLRxkroYbQgjgztJ6K1MRmQcJqV+ca0DQFvyatKNgebxP0cSZodo5jega3GQxj7qVrSxHOIn69LsM8PBP721w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431036; c=relaxed/simple;
	bh=HQY4AWs4bi0pQXEv6LtI3f0RcQnw7yA5Mz/tA64yBog=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CJKYDQlbJExWGrij4OSv6VQ/HNlaYuaVjbXpLraFNkhMEp3N7oEpkFGaGL86AMgs7QlUpmqTa7qDIFEasVWHQ+rafcGOn7rWXbkVfvBxDFGXpiWrJj5ZQHj5cL7DrFFMTMcwiku8KGAuisMMWaw6KAtm3r+QMhbj8bZyTdDhP00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KccNg6bD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70690b6826fso153075b3a.1
        for <linux-mmc@vger.kernel.org>; Wed, 26 Jun 2024 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719431033; x=1720035833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INsSPbtGqJGHOkblxtNd1zECa7M89eF2RAFMCb8l9+E=;
        b=KccNg6bDpWkRMxvch/pvqhFKGF+73MN9ncTHlHU5Zf1bnhZ8e1ckA/PH4JOlfE3Bvh
         k3iBpq8WcS3UGYv95C5vt6V3qneK8EaM8VWJqHCINCaGyfFp1vlzoyHekq4UfFCJmLiz
         fhBmFh3uuwD+YDnQdpuY0VQKJp+OBSenfCYARKAzefbfVKySCQnAM46RXdj9stwNUp0C
         uuOwuWJBqOBun7RcQND4pvs/Do+MMRqJ0YxIAeO7b8OB2dRvRSzm/AQ+HhXo8Eo3Weeg
         F0htQ90QmJtm60KoBbt5ohWJkRnqX0oAj0qH3TGjHa194AkFN5ZgUxC/fmTso78xa9lA
         OrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431033; x=1720035833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INsSPbtGqJGHOkblxtNd1zECa7M89eF2RAFMCb8l9+E=;
        b=Tt9vOFw4EiaJ4RQsxqFZc/i39WUg8SBimed5JNTqKEUa8qtjUDYm4OVo363iqVlJnR
         f5DxQCuVm4eRxQ8zaqsbCe2M40yFXHDQUj/4BUnychGDVW27z9wT7/Mh4snCeYciitYF
         bNXO6djYF7cbvBmITjA9IsDYD2rXFz3IZ+kKe7llHOGgSZJhGQ3sfR7vrR0URRhrg8pa
         RqMJLZFUG2bS2xAYLrF61bJeKKkrcpOvJ65A1MaR2uf8YbUVRyT/jnIemkZdXPSFrP0c
         4nYWRM9vISbHUmP6++uJ4VsO8fhOT9ppLGn73hsFnslkktn6CYR3OILCWLE0gNiOH/GA
         3UzA==
X-Forwarded-Encrypted: i=1; AJvYcCXrf+TBQmBrNsuIC9VRUwvNZE4ULNXfmoONT+zP6MwQ8tGKXKLH5ptUuBI4va0yK4XojCrlD/wo4TbsRX5z8mH9GJuZafYs0Z+8
X-Gm-Message-State: AOJu0YygyJ1OKRZ32mY8HEX5EveKJGEIAqdQx760CoaW25Hto6U1hGUP
	fLgRFTIPb+mFNOjTHbaWuIOHC+ocX+kJ1r60FmCdwKadYzHZIwU/Def/A9s5tUM=
X-Google-Smtp-Source: AGHT+IHOftT8C5pvp5IDdZLc3OtfymMvuC7JHSCp3Kk76L/dndWQHnczRDkTKXHWtsTvTLaHozfsYw==
X-Received: by 2002:a05:6a00:6013:b0:704:173c:5111 with SMTP id d2e1a72fcca58-70667e04c57mr13186939b3a.3.1719431033252;
        Wed, 26 Jun 2024 12:43:53 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70690b37fabsm4667534b3a.1.2024.06.26.12.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 12:43:52 -0700 (PDT)
Message-ID: <2de992b3-d71c-40f2-ad68-76a9f48338d4@kernel.dk>
Date: Wed, 26 Jun 2024 13:43:49 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] block: partitions: populate fwnode
To: Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Al Viro <viro@zeniv.linux.org.uk>, Li Lingfeng <lilingfeng3@huawei.com>,
 Christian Heusel <christian@heusel.eu>, Min Li <min15.li@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Hannes Reinecke <hare@suse.de>, Mikko Rapeli <mikko.rapeli@linaro.org>,
 Yeqi Fu <asuk4.q@gmail.com>, Victor Shih <victor.shih@genesyslogic.com.tw>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Li Zhijian <lizhijian@fujitsu.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-block@vger.kernel.org
References: <cover.1719368448.git.daniel@makrotopia.org>
 <afa870ec6ac1027561d1c002205ab1e05358a46c.1719368448.git.daniel@makrotopia.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <afa870ec6ac1027561d1c002205ab1e05358a46c.1719368448.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/24 8:50 PM, Daniel Golle wrote:
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index ab76e64f0f6c..f88829e254e6 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -10,6 +10,8 @@
>  #include <linux/ctype.h>
>  #include <linux/vmalloc.h>
>  #include <linux/raid/detect.h>
> +#include <linux/property.h>
> +
>  #include "check.h"
>  
>  static int (*const check_part[])(struct parsed_partitions *) = {
> @@ -281,6 +283,42 @@ static ssize_t whole_disk_show(struct device *dev,
>  }
>  static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
>  
> +static struct fwnode_handle *find_partition_fwnode(struct block_device *bdev)
> +{
> +	struct fwnode_handle *fw_parts, *fw_part;
> +	struct device *ddev = disk_to_dev(bdev->bd_disk);
> +	const char *partname, *uuid;
> +	u32 partno;
> +
> +	fw_parts = device_get_named_child_node(ddev, "partitions");
> +	if (!fw_parts)
> +		fw_parts = device_get_named_child_node(ddev->parent, "partitions");
> +
> +	if (!fw_parts)
> +		return NULL;

That last if check should to inside the previous one.

> +	fwnode_for_each_child_node(fw_parts, fw_part) {
> +		if (!fwnode_property_read_string(fw_part, "uuid", &uuid) &&
> +		    (!bdev->bd_meta_info || strlen(uuid) > PARTITION_META_INFO_UUIDLTH ||
> +		     strncmp(uuid, bdev->bd_meta_info->uuid, PARTITION_META_INFO_UUIDLTH)))
> +			continue;
> +
> +		if (!fwnode_property_read_string(fw_part, "partname", &partname) &&
> +		    (!bdev->bd_meta_info || strlen(uuid) > PARTITION_META_INFO_VOLNAMELTH ||
> +		     strncmp(partname, bdev->bd_meta_info->volname,
> +			     PARTITION_META_INFO_VOLNAMELTH)))
> +			continue;

This is pretty hard to make sense of...

-- 
Jens Axboe


